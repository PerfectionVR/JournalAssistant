-- Journal Assistant - Planner engine (generic)
--
-- Build() asks every registered task SOURCE for tasks, evaluates progress with
-- the registered METRICS, keeps per-task state (done / skipped / manual),
-- sorts guide-tab tasks into groups and orders the rest into a route
-- (Routes.lua). It knows nothing about professions or quests: those modules
-- plug in through the hooks below (see Professions/Plan.lua, Guides/Plan.lua).
--
--   PL:AddSource(order, name, fn(ctx))        add tasks (lower order runs first)
--   PL:AddStage(stage, fn(ctx, result))       "prepare" | "linked" | "finish"
--   PL:AddMetric(fn(t, m, ctx))               -> nil | { done, frac, text }
--   PL:AddTaskPrepare(fn(t, state, ctx))      per-task bookkeeping before evaluation
--   PL:AddProgressMark(fn(t, ctx))            -> value; a manual "done" expires when it changes
--   PL:AddDoneHandler(fn(t, done))            side effects of marking a task done / not done
--
-- Task fields used here: id, title, kind, prof (category key), group (guide
-- tab key), blocked, value, metric, materials, expands (its steps are added as
-- separate tasks when switched on).

local _, ns = ...
local PL = { util = {} }
ns.Planner = PL

PL.tasks, PL.byId, PL.ordered, PL.blocked, PL.doneList, PL.skippedList = {}, {}, {}, {}, {}, {}
PL.route, PL.objectives, PL.groups = {}, {}, {}
PL.active = nil

local sources, metrics, prepares, marks, doneHandlers = {}, {}, {}, {}, {}
local stages = { prepare = {}, linked = {}, finish = {} }

function PL:AddSource(order, name, fn)
    sources[#sources + 1] = { order = order, name = name, fn = fn }
    table.sort(sources, function(a, b) return a.order < b.order end)
end
function PL:AddStage(stage, fn) table.insert(stages[stage], fn) end
function PL:AddMetric(fn) metrics[#metrics + 1] = fn end
function PL:AddTaskPrepare(fn) prepares[#prepares + 1] = fn end
function PL:AddProgressMark(fn) marks[#marks + 1] = fn end
function PL:AddDoneHandler(fn) doneHandlers[#doneHandlers + 1] = fn end
PL.doneHandlers = doneHandlers

---------------------------------------------------------------------------
-- Shared helpers for task sources (PL.util)
---------------------------------------------------------------------------
local U = PL.util

function U.now() return time and time() or 0 end
local now = U.now

function U.contains(list, v)
    if not list then return false end
    for i = 1, #list do if list[i] == v then return true end end
    return false
end

-- planner weight of a category (profession or guide group), see Core priorities
function U.prio(key)
    return ns.PRIORITY_WEIGHT[ns:GetPriority(key)] or 1
end

function U.AddTask(ctx, t)
    t.metric = t.metric or {}
    t.reasons = t.reasons or {}
    ctx.tasks[#ctx.tasks + 1] = t
    ctx.byId[t.id] = t
    return t
end

-- Material demand shared by all tasks: rg = { name, itemID }
function U.AddDemand(ctx, rg, need, reason, sourceId)
    local name = rg.name or ns.Inventory.ItemName(rg.itemID) or ("item:" .. tostring(rg.itemID))
    local lname = string.lower(name)
    local d = ctx.demand[lname]
    if not d then
        d = { name = name, itemID = rg.itemID, need = 0, reasons = {}, crafts = {} }
        ctx.demand[lname] = d
        ctx.demandOrder[#ctx.demandOrder + 1] = lname
    end
    d.need = d.need + need
    d.reasons[#d.reasons + 1] = reason
    d.crafts[#d.crafts + 1] = sourceId
    return d
end

function U.SafetyFactor(zone, level, areaMin)
    local s = ns.Routes:Safety(zone, level, areaMin)
    if s == "caution" then return 0.6, s end
    if s == "danger" then return 0.2, s end
    return 1, s
end

-- returns text, safety, effectiveMinLevel
function U.CautionText(zone, level, areaMin, areaName)
    local s, z, min = ns.Routes:Safety(zone, level, areaMin)
    if s == "caution" or s == "danger" then
        if areaMin and areaName then
            return ("%s: mobs level %d+ (you are %d)."):format(areaName, areaMin, level), s, min
        elseif z then
            return ("%s has level %d-%d mobs (you are %d)."):format(zone, z.min, z.max, level), s, min
        end
    end
    return nil, s, min
end

-- your faction's main city (Auction House, trainers)
function U.Hub(ctx)
    return (ns.Data.hubs[ctx.faction] or ns.Data.hubs.Alliance)[1]
end

function PL:State(id)
    local s = ns.char.taskState[id]
    if not s then
        s = { created = now() }
        ns.char.taskState[id] = s
    end
    return s
end

-- value that marks "progress" for a task (a manual done expires when it changes)
function PL:MarkFor(t, ctx)
    ctx = ctx or PL.lastCtx
    for _, fn in ipairs(marks) do
        local v = fn(t, ctx)
        if v ~= nil then return v end
    end
end

---------------------------------------------------------------------------
-- Evaluation: materials (generic) + registered metrics
---------------------------------------------------------------------------
local function Evaluate(t, ctx)
    local parts, done, frac, n = {}, true, 0, 0
    local m = t.metric
    for _, fn in ipairs(metrics) do
        local r = fn(t, m, ctx)
        if r then
            if not r.done then done = false end
            if r.frac then frac, n = frac + r.frac, n + 1 end
            if r.text then parts[#parts + 1] = r.text end
        end
    end
    if t.materials and #t.materials > 0 then
        local have, need = 0, 0
        for _, mat in ipairs(t.materials) do
            mat.have = ns.Inventory:Count(mat)
            have = have + math.min(mat.have, mat.need)
            need = need + mat.need
        end
        if m.materials then
            if have < need then done = false end
            frac, n = frac + (need > 0 and have / need or 1), n + 1
        end
        parts[#parts + 1] = ("Items %d/%d"):format(have, need)
    end
    if n == 0 then done = false end
    t.progress = n > 0 and frac / n or 0
    t.progressText = table.concat(parts, "  ·  ")
    return done
end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------
local function NewGroup() return { active = {}, blocked = {}, done = {}, skipped = {} } end

function PL:Build()
    local ctx = {
        level = ns.PlayerLevel(), faction = ns.PlayerFaction(), curZone = ns.Routes:CurrentZone(),
        tasks = {}, byId = {}, demand = {}, demandOrder = {},
    }
    PL.lastCtx = ctx
    for _, fn in ipairs(stages.prepare) do fn(ctx) end
    for _, s in ipairs(sources) do s.fn(ctx) end
    for _, fn in ipairs(stages.linked) do fn(ctx) end

    -- state, completion, announcements
    local stamp = now()
    local actionable, blocked, doneList, skipped, groups = {}, {}, {}, {}, {}
    for _, t in ipairs(ctx.tasks) do
        local s = self:State(t.id)
        local wasSeen = s.seen
        s.seen = stamp
        for _, fn in ipairs(prepares) do fn(t, s, ctx) end
        local autoDone = Evaluate(t, ctx)
        if ns.Prices then ns.Prices:Annotate(t) end
        local mark = PL:MarkFor(t, ctx)
        if s.done and not autoDone then
            if not s.manual then
                s.done = nil -- condition no longer satisfied (new goal)
            elseif mark ~= nil and mark ~= s.doneMark then
                s.done, s.manual = nil, nil -- manual completion expires after progress
            end
        end
        if autoDone and not s.done then
            s.done, s.doneMark = true, mark
            -- a guide entry that is already complete the first time it is
            -- listed (done before) is not announced
            if wasSeen or not t.group then ns:Fire("TASK_COMPLETED", t) end
        end
        t.done, t.skipped = s.done and true or false, s.skipped and true or false
        if t.group then
            -- guide-tab tasks use the On/Off switch instead of Skip: an old
            -- "skipped" state just means Off, and the task is listed again
            if s.skipped then s.skipped = nil; t.skipped = false end
            -- guide groups get their own dashboard section, outside the route
            local g = groups[t.group] or NewGroup()
            groups[t.group] = g
            local list = t.done and g.done or (t.blocked and g.blocked or g.active)
            list[#list + 1] = t
            -- a task switched On also goes into the Plan, unless its steps were
            -- added as their own tasks (t.expands)
            t.tracked = ns.char.tracked[t.id] or nil
            if t.tracked and not t.expands and not t.done then
                if t.blocked then blocked[#blocked + 1] = t else actionable[#actionable + 1] = t end
            end
        elseif t.skipped then skipped[#skipped + 1] = t
        elseif t.done then doneList[#doneList + 1] = t
        elseif t.blocked then blocked[#blocked + 1] = t
        else actionable[#actionable + 1] = t end
    end

    -- prune old state (not seen for 21 days and not skipped)
    for id, s in pairs(ns.char.taskState) do
        if s.seen and stamp - s.seen > 21 * 86400 and not s.skipped then ns.char.taskState[id] = nil end
    end

    -- order
    local ordered, seq
    if ns.char.routeMode then
        ordered, seq = ns.Routes:Order(actionable, ctx.curZone)
    else
        ordered, seq = actionable, {}
        table.sort(ordered, function(a, b) return (a.value or 0) > (b.value or 0) end)
    end
    table.sort(blocked, function(a, b) return (a.value or 0) > (b.value or 0) end)
    for i, t in ipairs(ordered) do t.order = i end

    -- group lists: available first (by level, then value), then gated
    local function byLevelValue(a, b)
        local la, lb = a.chainLevel or 0, b.chainLevel or 0
        if la ~= lb then return la < lb end
        return (a.value or 0) > (b.value or 0)
    end
    for _, g in pairs(groups) do
        table.sort(g.active, byLevelValue)
        table.sort(g.blocked, byLevelValue)
    end

    PL.tasks, PL.byId = ctx.tasks, ctx.byId
    PL.ordered, PL.blocked, PL.doneList, PL.skippedList = ordered, blocked, doneList, skipped
    PL.route, PL.groups, PL.demand = seq, groups, ctx.demand
    PL.objectives = {}
    local result = { ordered = ordered, blocked = blocked, groups = groups }
    for _, fn in ipairs(stages.finish) do fn(ctx, result) end

    -- active task: user selection wins while it is actionable;
    -- just switched on in a guide tab: make its first routed task active
    if PL.selectAfterTrack then
        local id = PL.selectAfterTrack
        PL.selectAfterTrack = nil
        for _, t in ipairs(ordered) do
            if t.id == id or t.id:sub(1, #id + 1) == id .. ":" then ns.char.selectedTask = t.id; break end
        end
    end
    local sel = ns.char.selectedTask and ctx.byId[ns.char.selectedTask]
    local active = (sel and not sel.done and not sel.skipped and not sel.blocked) and sel or ordered[1]
    local prevId = PL.active and PL.active.id
    PL.active = active
    if (active and active.id) ~= prevId then
        ns:Fire("ACTIVE_CHANGED", active)
    end
end
