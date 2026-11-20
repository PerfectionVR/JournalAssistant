-- Journal Assistant - Herbalism and Mining
--
-- Best SAFE zone with skill-giving nodes, weighted by the Forever guide route
-- band, nodes that crafting needs, rank destinations, fishing water and your
-- current zone.

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, prio, contains, SafetyFactor, CautionText = U.AddTask, U.prio, U.contains, U.SafetyFactor, U.CautionText
local NODE_GAIN, VERB, NodeColor, ItemNode, BandBonus = PP.NODE_GAIN, PP.VERB, PP.NodeColor, PP.ItemNode, PP.BandBonus

function PP:AddGathering(ctx, key, p, target, nodes)
    local progressing = p and p.skill < math.min(target, p.maxSkill)
    local skill = p and p.skill or 0
    local verb = VERB[key] or "Gather"

    -- crafting demand this profession can supply
    local wanted = {}
    if p then
        for _, lname in ipairs(ctx.demandOrder) do
            local d = ctx.demand[lname]
            local e = ItemNode(d.name)
            if e and e.prof == key and skill >= e.node.skill and not d.coveredBy and ns.Inventory:Count(d) < d.need then
                wanted[#wanted + 1] = { d = d, h = e.node }
            end
        end
    end
    if not progressing and #wanted == 0 then return end

    local cands, nextUnlock = {}, nil
    if progressing then
        for _, h in ipairs(nodes) do
            local c = NodeColor(skill, h.skill)
            if c == "red" then
                if not nextUnlock or h.skill < nextUnlock.skill then nextUnlock = h end
            elseif NODE_GAIN[c] then
                cands[#cands + 1] = { h = h, color = c, gain = NODE_GAIN[c] }
            end
        end
    end
    local goal
    if progressing then
        goal = math.min(target, p.maxSkill)
        if nextUnlock and nextUnlock.skill < goal and nextUnlock.skill > skill then goal = nextUnlock.skill end
    end

    local function scoreZone(zone, onlyWanted)
        local score, here, bestGain = 0, {}, 0
        if not onlyWanted then
            for _, c in ipairs(cands) do
                if contains(c.h.zones, zone) then
                    here[#here + 1] = c
                    if c.gain > bestGain then bestGain = c.gain end
                end
            end
            table.sort(here, function(a, b) return a.gain > b.gain end)
            -- skill gain dominates; combining bonuses below only break near-ties
            for i, c in ipairs(here) do score = score + 2.5 * c.gain / i end
        end
        local mats = {}
        for _, w in ipairs(wanted) do
            if not w.d.coveredBy and contains(w.h.zones, zone) then
                mats[#mats + 1] = w
                score = score + 0.9
            end
        end
        if score <= 0 then return 0 end
        if not onlyWanted then score = score + BandBonus(key, skill, zone) end
        if ctx.fishing and (ns.Data.fishingZones[zone] or 999) <= ctx.fishing.skill then score = score + 0.4 end
        if ctx.rankZones[zone] then score = score + 0.8 end
        if ctx.gatherZones[zone] then score = score + 0.6 end
        if zone == ctx.curZone then score = score + 0.5 end
        local f = SafetyFactor(zone, ctx.level)
        score = score * f / (1 + 0.15 * ns.Routes:Distance(ctx.curZone, zone))
        return score, here, mats, bestGain
    end

    local function pickZone(onlyWanted)
        local bestZ, bestS, bestHere, bestMats, bestGain
        for zone, z in pairs(ns.Data.zones) do
            if not z.city and ns.Routes:IsAllowed(zone, ctx.level) then
                local s, here, mats, g = scoreZone(zone, onlyWanted)
                if s > 0 and (not bestS or s > bestS) then bestZ, bestS, bestHere, bestMats, bestGain = zone, s, here, mats, g end
            end
        end
        return bestZ, bestHere, bestMats, bestGain
    end

    local function makeTask(zone, here, mats, bestGain, skillTask)
        local names = {}
        if skillTask then for i = 1, math.min(3, #here) do names[#names + 1] = here[i].h.name end end
        for _, w in ipairs(mats) do if not contains(names, w.h.name) then names[#names + 1] = w.h.name end end
        local id = ("gather:%s:%s%s"):format(key, skillTask and "" or "mats:", zone)
        local materials, matNeed = {}, 0
        for _, w in ipairs(mats) do
            w.d.coveredBy = id
            materials[#materials + 1] = { name = w.d.name, itemID = w.d.itemID, need = w.d.need, demand = w.d }
            matNeed = matNeed + w.d.need
        end
        local lines, est = {}, nil
        if skillTask then
            est = math.ceil((goal - skill) / math.max(0.25, bestGain) * 1.1)
            local why = (nextUnlock and goal == nextUnlock.skill) and (" (unlocks " .. nextUnlock.name .. ")") or ""
            lines[#lines + 1] = ("%s %d -> %d%s: ~%d nodes."):format(p.name, skill, goal, why, est)
            local colors = {}
            for i = 1, math.min(3, #here) do colors[#colors + 1] = here[i].h.name .. " (" .. here[i].color .. ")" end
            if #colors > 0 then lines[#lines + 1] = "Skill-giving here: " .. table.concat(colors, ", ") end
            local bonus, band = BandBonus(key, skill, zone)
            if band then
                lines[#lines + 1] = bonus > 0 and ("Forever guide zone for %d-%d%s."):format(band.from, band.to, band.note and (" - " .. band.note) or "")
                    or ("Forever guides use %s for %d-%d; not safe or suitable at your level, so this zone was chosen."):format(table.concat(band.zones, " / "), band.from, band.to)
            end
        end
        for _, w in ipairs(mats) do
            lines[#lines + 1] = ("Need %d %s for %s"):format(w.d.need, w.d.name, table.concat(w.d.reasons, "; "))
        end
        if ns.Data.tips and ns.Data.tips[key] then lines[#lines + 1] = ns.Data.tips[key] end
        local reasons = {}
        if skillTask then reasons[#reasons + 1] = p.name .. " to " .. goal end
        if #mats > 0 then reasons[#reasons + 1] = "materials for crafting" end
        if ctx.rankZones[zone] then reasons[#reasons + 1] = "rank unlock in the same zone" end
        local title
        if #mats > 0 and #mats == #names then
            title = ("%s %d %s in %s"):format(verb, matNeed, names[1] .. (#names > 1 and " +" .. (#names - 1) or ""), zone)
        else
            title = ("%s %s in %s"):format(verb, table.concat(names, ", "), zone)
        end
        AddTask(ctx, {
            id = id, kind = "gather", prof = key,
            title = title, detail = table.concat(lines, "\n"),
            zone = zone, materials = materials, qty = est,
            caution = CautionText(zone, ctx.level), confidence = "forever-guide",
            value = ((skillTask and 4 * math.max(0.25, bestGain or 0) or 0) + 0.8 * #mats) * prio(key),
            metric = { skillKey = skillTask and key or nil, skillGoal = skillTask and goal or nil, materials = #mats > 0 },
            reasons = reasons,
        })
        ctx.gatherZones[zone] = true
    end

    if progressing then
        self:AddLevelGate(ctx, key, p.name, skill)
        local zone, here, mats, g = pickZone(false)
        if zone then
            makeTask(zone, here, mats, g, true)
        else
            AddTask(ctx, {
                id = "gather:" .. key .. ":none", kind = "gather", prof = key,
                title = ("No safe %s zone at your level"):format(p.name),
                detail = ("No zone that is safe at level %d has nodes that still give skill at %d. Level up, or enable 'Allow dangerous zones'."):format(ctx.level, skill),
                blocked = "No zone safe for your level", confidence = "forever-guide", value = 1,
            })
        end
    end
    for _ = 1, 2 do
        local left = false
        for _, w in ipairs(wanted) do if not w.d.coveredBy then left = true end end
        if not left then break end
        local zone, here, mats, g = pickZone(true)
        if not zone or #mats == 0 then break end
        makeTask(zone, here, mats, g, false)
    end
end
