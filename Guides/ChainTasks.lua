-- Journal Assistant - Quest chain tasks
--
-- Turns a list of quest chains (class quests, camping) into guide-tab tasks and,
-- for chains switched On, into Plan tasks per step / objective.

local _, ns = ...
local PL = ns.Planner
local GP = ns.GuidePlan
local U = PL.util
local AddTask, prio, now, CautionText = U.AddTask, U.prio, U.now, U.CautionText

function GP:AddChainGroup(ctx, chains, group, label, prioKey)
    local CQ = ns.QuestChains
    local states = {}
    for _, c in ipairs(chains) do states[c.key] = CQ:State(c) end
    for _, c in ipairs(chains) do
        local st = states[c.key]
        local available = ctx.level >= c.level
        local soon = not available and c.level <= ctx.level + 4
        if st.complete then
            -- completed chains stay listed (under "Completed" on the tab)
            AddTask(ctx, {
                id = string.lower(group) .. ":" .. c.key, kind = "quest", prof = prioKey, group = group,
                title = label .. c.title, detail = "Reward: " .. (c.reward or "?") .. "\nCompleted. Right-click to put it back if this is wrong.",
                confidence = c.confidence == "unverified" and "unknown" or "forever-guide",
                metric = { questChain = c.key }, expands = true, chainLevel = c.level, value = 0,
                reasons = { "completed quest chain" },
            })
        elseif available or soon then
            local prev = c.after and CQ:ChainByKey(c.after)
            -- a prerequisite chain counts even when it is not listed (other race / class)
            local prevDone = not prev or (states[c.after] or CQ:State(prev)).complete
            local s = c.start or {}
            local cur = st.current
            -- what the current step still asks for (Wowhead Forever objective data;
            -- progress from your quest log, or the items in your bags)
            local objs = cur and CQ:Objectives(cur)
            local remaining, started = nil, st.inLog
            if objs then
                remaining = {}
                for _, e in ipairs(objs) do
                    if e.have > 0 then started = true end
                    if not e.done then remaining[#remaining + 1] = e end
                end
                -- go for a safe objective first
                table.sort(remaining, function(a, b)
                    local _, sa = CautionText(a.o.zone, ctx.level, a.o.areaMin, a.o.dungeon)
                    local _, sb = CautionText(b.o.zone, ctx.level, b.o.areaMin, b.o.dungeon)
                    if (sa == "danger") ~= (sb == "danger") then return sb == "danger" end
                    return a.index < b.index
                end)
            end
            local pickup = cur and CQ:StepStart(c, cur)
            local turnin = cur and CQ:StepEnd(c, cur)
            -- where to go now: not started -> the quest giver; started -> the
            -- next objective still open; everything done -> the turn-in NPC
            local objLoc = started and remaining and remaining[1] and remaining[1].o
            local loc
            if objLoc then loc = objLoc
            elseif cur and cur.zone then loc = cur
            elseif started then loc = turnin or s
            else loc = pickup or s end
            loc = loc or {}
            local zone = loc.zone
            local caution, safety, effMin = CautionText(zone, ctx.level, (objLoc and objLoc.areaMin) or (c.area and c.area.min),
                (objLoc and objLoc.dungeon) or (c.area and c.area.name))
            local blocked
            if not available then
                blocked = ("Available at level %d (you are %d)"):format(c.level, ctx.level)
            elseif not prevDone then
                blocked = ("Finish \"%s\" first"):format(prev.title)
            elseif cur and not st.inLog and CQ:MissingPrereq(cur) then
                -- the quest giver only offers it after another quest (Wowhead "Requires")
                blocked = ("Finish \"%s\" first"):format(CQ:MissingPrereq(cur).name)
            elseif safety == "danger" and not ns.db.allowDangerous and not st.inLog then
                -- a quest you already have is never hidden for level: its objectives
                -- show a caution instead (one named mob above your level, e.g. Gutspill)
                blocked = ("Reach level %d first (you are %d)"):format(effMin or c.level, ctx.level)
            end
            -- caution for one objective: name the mob / item and its level when known
            local function ObjCaution(o)
                local oc, os, omin = CautionText(o.zone, ctx.level, o.areaMin, o.dungeon)
                if os == "danger" and st.inLog and o.areaMin and not o.dungeon then
                    -- "from" already carries the level, e.g. "Gutspill (32)"
                    local who = (o.from and o.from:find("%(")) and o.from
                        or ("%s (%d)"):format(o.from or o.name or "The target", o.areaMin)
                    oc = ("%s - you are level %d; bring help if needed."):format(who, ctx.level)
                    os = "caution"
                end
                return oc, os, omin
            end
            local function ObjText(e)
                return ("%s %d/%d"):format(e.o.kill and ("Kill " .. (e.o.name or "?")) or (e.o.name or "?"), e.have, e.need)
            end
            local function ObjWhere(o)
                local parts = {}
                if o.from then parts[#parts + 1] = (o.item and "drops from " or "") .. o.from end
                if o.dungeon then parts[#parts + 1] = "inside " .. o.dungeon end
                if o.zone then parts[#parts + 1] = o.zone end
                return table.concat(parts, ", ")
            end
            local function Place(p) return p and (p.npc and (p.npc .. (p.zone and (", " .. p.zone) or "")) or p.zone) or "?" end
            local lines = { "Reward: " .. (c.reward or "?") }
            if s.npc or s.zone or s.note then
                lines[#lines + 1] = ("Start: %s%s%s"):format(s.npc or "", s.zone and ((s.npc and ", " or "") .. s.zone) or "",
                    s.note and (" (" .. s.note .. ")") or "")
            end
            lines[#lines + 1] = "Steps:"
            for i, step in ipairs(c.steps) do
                local mark
                if i <= st.nDone then mark = "[done]"
                elseif step == cur then mark = st.inLog and "[in your quest log]" or "[next]"
                else mark = "[ ]" end
                lines[#lines + 1] = ("  %s %s%s"):format(mark, step.name, (step == cur and step.note) and (" - " .. step.note) or "")
                if step == cur and objs then
                    for _, e in ipairs(objs) do
                        lines[#lines + 1] = ("      %s%s|r - %s"):format(e.done and ns.GREEN or ns.ORANGE, ObjText(e), ObjWhere(e.o))
                    end
                end
                if step == cur and turnin and turnin.npc then lines[#lines + 1] = "      Turn in: " .. Place(turnin) end
            end
            if c.zones then lines[#lines + 1] = "Visits: " .. table.concat(c.zones, ", ") end
            if c.note then lines[#lines + 1] = c.note end
            if c.confidence == "unverified" then
                lines[#lines + 1] = "Quest details are not verified for Forever - your trainer gives the exact quest. It completes automatically once you know the reward spell."
            end
            local title = (label .. c.title) .. (st.inLog and " (in progress)" or "")
            local gid = string.lower(group) .. ":" .. c.key
            local value = (c.optional and 2.5 or 6) * prio(prioKey)
            local conf = c.confidence == "unverified" and "unknown" or "forever-guide"
            local function Dest(p) return p and p.x and p.zone and { zone = p.zone, x = p.x, y = p.y, mapID = p.mapID, npc = p.npc, approx = true } or nil end
            -- Switched On (guide tab): the quest goes into the Plan, step by step
            if ns.char.tracked and ns.char.tracked[gid] then
                -- current step: one task per open objective, routed to where it is
                if started and remaining then
                    for _, e in ipairs(remaining) do
                        local o = e.o
                        local oc, os, omin = ObjCaution(o)
                        local ob = blocked or (os == "danger" and not ns.db.allowDangerous
                            and ("Reach level %d first (you are %d)"):format(omin or o.areaMin or c.level, ctx.level)) or nil
                        AddTask(ctx, {
                            id = gid .. ":obj:" .. e.index, kind = "quest", prof = prioKey,
                            title = ("%s: %s"):format(cur.name, ObjText(e)),
                            detail = ("%s.\nQuest: %s (%s)"):format(ObjWhere(o), cur.name, c.title),
                            zone = o.zone, npc = o.from,
                            dest = o.x and { zone = o.zone, x = o.x, y = o.y, mapID = o.mapID, npc = o.from, approx = true } or nil,
                            blocked = ob, caution = not ob and oc or nil,
                            confidence = conf, value = value * 1.3,
                            metric = { questObj = { step = cur, index = e.index } },
                            reasons = { "objective of a quest you switched on" }, chainLevel = c.level,
                        })
                    end
                end
                local prevName
                for i = st.nDone + 1, #c.steps do
                    local step = c.steps[i]
                    local first = i == st.nDone + 1
                    local openLeft = first and started and remaining and #remaining > 0
                    local stTitle, sl
                    if first and started then
                        sl = (step.zone and step) or turnin or s
                        stTitle = ("%s: turn in to %s"):format(step.name, sl.npc or "the quest giver")
                    else
                        sl = (step.zone and step) or CQ:StepStart(c, step) or (first and loc) or {}
                        stTitle = ("%s %d/%d: %s"):format(c.title, i, #c.steps, step.name)
                            .. (sl.npc and (" - pick up from " .. sl.npc) or "")
                    end
                    local sz = sl.zone
                    local sCaution, sSafety, sMin = CautionText(sz, ctx.level, c.area and c.area.min, c.area and c.area.name)
                    local sBlocked = blocked
                        or (openLeft and ("Finish the objectives first (%d left)"):format(#remaining))
                        or (not first and ("After \"%s\""):format(prevName))
                        or (sSafety == "danger" and not ns.db.allowDangerous and ("Reach level %d first (you are %d)"):format(sMin or c.level, ctx.level))
                        or nil
                    local more = {}
                    for j = i + 1, #c.steps do more[#more + 1] = c.steps[j].name end
                    local detail = table.concat({
                        step.note or (first and i == 1 and s.note) or "",
                        ("Quest chain: %s - reward: %s"):format(c.title, c.reward or "?"),
                        #more > 0 and ("Then: " .. table.concat(more, " > ")) or "Last step of the chain.",
                    }, "\n")
                    AddTask(ctx, {
                        id = gid .. ":step:" .. i, kind = "quest", prof = prioKey,
                        title = stTitle,
                        detail = (detail:gsub("^\n", "")),
                        zone = sz, npc = sl.npc, dest = Dest(sl),
                        blocked = sBlocked, caution = not sBlocked and sCaution or nil,
                        confidence = conf,
                        value = value * 1.3 - (i - st.nDone - 1) * 0.1,
                        reasons = { "quest chain you switched on" },
                        questStep = step, chainLevel = c.level,
                    })
                    prevName = step.name
                end
            end
            AddTask(ctx, {
                id = gid, kind = "quest", prof = prioKey, group = group, tracked = ns.char.tracked and ns.char.tracked[gid] or nil,
                title = title, detail = table.concat(lines, "\n"),
                zone = zone, npc = loc.npc or loc.from, dest = Dest(loc),
                blocked = blocked, caution = not blocked and caution or nil,
                confidence = c.confidence == "unverified" and "unknown" or "forever-guide",
                value = value,
                metric = { questChain = c.key }, expands = true,
                reasons = { ("quest chain (level %d)"):format(c.level) },
                chainLevel = c.level,
            })
        end
    end
end
