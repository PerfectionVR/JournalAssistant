-- Journal Assistant - Professions in the planner
--
-- Plugs the profession task sources into the generic planner engine:
--   1. rank tasks   - cap below target: trainer, book or quest (Ranks.lua)
--   2. craft tasks  - one committed step per crafting profession (Crafting.lua),
--                     better recipes to learn / buy (BetterRecipes.lua); only one
--                     step requests materials at a time
--   3. gathering    - Herbalism and Mining (Gathering.lua)
--   4. skinning     - guide band zone that is safe for your level (Skinning.lua)
--   5. fishing      - combined with other zones / Cooking fish (Fishing.lua)
--   6. obtain       - material demand nothing above covers (Obtain.lua)
-- plus the skill / cap progress metrics, the "Reach level X" gate advice and
-- the per-profession objective line shown on the Professions tab.

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util

local function Target(key) return ns:GetTarget(key) end

ns.Settings:AddCycle("Default target for all professions", { [150] = "150", [225] = "225", [300] = "300" },
    function() return ns.char.defaultTarget end,
    function(v) ns.char.defaultTarget = v; ns:RequestRefresh("target") end)

-- context: detected professions that are not paused
PL:AddStage("prepare", function(ctx)
    ns.Professions:Scan()
    local profs, active = {}, {}
    for _, p in ipairs(ns.Professions.list) do
        if not ns.Professions:IsPaused(p.key) then
            profs[p.key] = p
            active[#active + 1] = p
        end
    end
    ctx.profs, ctx.activeProfs, ctx.skills = profs, active, {}
    ctx.rankZones, ctx.gatherZones = {}, {}
    ctx.fishing = profs.FISHING
    for key, p in pairs(profs) do ctx.skills[key] = p.skill end
end)

-- sources (order matters: crafting demand feeds gathering, which feeds fishing / obtain)
PL:AddSource(10, "ranks", function(ctx)
    for key, p in pairs(ctx.profs) do
        local target = Target(key)
        if p.skill < target and p.maxSkill < target then PP:AddRank(ctx, p, target) end
    end
end)
PL:AddSource(20, "crafting", function(ctx)
    for _, p in ipairs(ctx.activeProfs) do
        if p.kind == "craft" then PP:AddCraft(ctx, p, Target(p.key)) end
    end
    PP:ApplyCraftFocus(ctx)
end)
PL:AddSource(30, "gathering", function(ctx)
    local h, m = ctx.profs.HERBALISM, ctx.profs.MINING
    PP:AddGathering(ctx, "HERBALISM", h, h and Target("HERBALISM") or 0, ns.Data.herbs)
    PP:AddGathering(ctx, "MINING", m, m and Target("MINING") or 0, ns.Data.ores)
end)
PL:AddSource(40, "skinning", function(ctx)
    if ctx.profs.SKINNING then PP:AddSkinning(ctx, ctx.profs.SKINNING, Target("SKINNING")) end
end)
PL:AddSource(50, "fishing", function(ctx)
    if ctx.profs.FISHING then PP:AddFishing(ctx, ctx.profs.FISHING, Target("FISHING")) end
end)
PL:AddSource(60, "obtain", function(ctx) PP:AddObtain(ctx) end)

-- metrics: skill goal and skill cap
PL:AddMetric(function(t, m, ctx)
    if not (m.skillKey and m.skillGoal) then return nil end
    local p = ctx.profs[m.skillKey]
    local cur = p and p.skill or 0
    local base = m.skillBase or cur
    local f = (m.skillGoal > base) and ns.Clamp((cur - base) / (m.skillGoal - base), 0, 1) or (cur >= m.skillGoal and 1 or 0)
    return { done = cur >= m.skillGoal, frac = f, text = ("Skill %d/%d"):format(cur, m.skillGoal) }
end)
PL:AddMetric(function(t, m, ctx)
    if not m.capGoal then return nil end
    local p = ctx.profs[m.capKey]
    local ok = p and p.maxSkill >= m.capGoal
    return { done = ok and true or false, frac = ok and 1 or 0, text = ("Cap %d/%d"):format(p and p.maxSkill or 0, m.capGoal) }
end)

-- skill goal bookkeeping: base skill of a step, "reached N" announcements
PL:AddTaskPrepare(function(t, s, ctx)
    local goal = t.metric.skillGoal
    if not goal then return end
    local p = t.metric.skillKey and ctx.profs[t.metric.skillKey]
    if s.goalSeen ~= goal then
        if s.goalSeen and p and p.skill >= s.goalSeen and s.goalSeen < goal then
            ns:Fire("TASK_COMPLETED", t, ("%s reached %d"):format(p.name, s.goalSeen))
        end
        s.goalSeen = goal
        if t.kind ~= "craft" then s.baseSkill = p and p.skill or 0 end
    end
    t.metric.skillBase = s.baseSkill
end)

-- a profession task marked done by hand comes back once your skill changes
PL:AddProgressMark(function(t, ctx)
    local key = t.metric and t.metric.skillKey
    local p = key and ((ctx and ctx.profs and ctx.profs[key]) or ns.Professions.byKey[key])
    return p and p.skill or nil
end)

-- material tasks know which crafting step(s) they supply; crafts with nothing
-- craftable wait on their material tasks
PL:AddStage("linked", function(ctx)
    for _, t in ipairs(ctx.tasks) do
        if t.kind ~= "craft" and t.materials then
            local seen = {}
            for _, mat in ipairs(t.materials) do
                for _, cid in ipairs(mat.demand and mat.demand.crafts or {}) do
                    local ct = ctx.byId[cid]
                    if ct and ct.step and not seen[cid] then
                        seen[cid] = true
                        t.forSteps = t.forSteps or {}
                        t.forSteps[#t.forSteps + 1] = ("%s (%d-%d)"):format(ct.step.recipe or "?", ct.step.from, ct.step.to)
                    end
                end
            end
        end
    end
    for _, t in ipairs(ctx.tasks) do
        if t.kind == "craft" and (t.craftable or 0) == 0 then
            t.waitingFor = {}
            for _, mat in ipairs(t.materials) do
                local cov = mat.demand and mat.demand.coveredBy
                if cov and ns.Inventory:Count(mat) < mat.need and not U.contains(t.waitingFor, cov) then
                    t.waitingFor[#t.waitingFor + 1] = cov
                end
            end
            if #t.waitingFor > 0 then t.reasons[#t.reasons + 1] = "after collecting materials" end
        end
    end
end)

-- level gates: what to do instead until you reach the recommended level;
-- then the one-line objective per profession
PL:AddStage("finish", function(ctx, r)
    local gates = {}
    for _, g in ipairs(r.blocked) do
        if g.gate then
            gates[g.prof] = g
            local lines = { g.detail, "", "Until then:" }
            for _, t in ipairs(r.ordered) do
                if t.prof == g.prof then
                    lines[#lines + 1] = "- Slower but safe: " .. t.title
                    break
                end
            end
            for _, t in ipairs(r.ordered) do
                if t.kind == "obtain" and t.materials then
                    for _, m in ipairs(t.materials) do
                        local e = PP.ItemNode(m.name)
                        if e and e.prof == g.prof then lines[#lines + 1] = "- Buy instead: " .. t.title; break end
                    end
                end
            end
            local n = 0
            for _, t in ipairs(r.ordered) do
                if t.prof ~= g.prof and n < 3 then
                    n = n + 1
                    lines[#lines + 1] = "- Meanwhile: " .. t.title .. (t.zone and (" (" .. t.zone .. ")") or "")
                end
            end
            lines[#lines + 1] = ("- Or reach level %d first, then follow the guide zone."):format(g.gateLevel)
            g.detail = table.concat(lines, "\n")
        end
    end

    local objectives = PL.objectives
    for _, p in ipairs(ns.Professions.list) do
        local target = Target(p.key)
        if ns.Professions:IsPaused(p.key) then
            objectives[p.key] = { text = "Paused - switched off, nothing is planned for it.", state = "paused" }
        elseif p.skill >= target then
            objectives[p.key] = { text = "Target reached.", state = "done" }
        else
            for _, t in ipairs(r.ordered) do
                if t.prof == p.key then
                    local g = gates[p.key]
                    objectives[p.key] = { text = g and ("Reach level %d for the guide zone - meanwhile: %s"):format(g.gateLevel, t.title) or t.title, task = t }
                    break
                end
            end
            if not objectives[p.key] then
                for _, t in ipairs(r.blocked) do
                    if t.prof == p.key then objectives[p.key] = { text = t.title .. " - " .. t.blocked, task = t, state = "blocked" }; break end
                end
            end
            if not objectives[p.key] then objectives[p.key] = { text = "No recommendation (all related tasks done or skipped)." } end
        end
    end
end)
