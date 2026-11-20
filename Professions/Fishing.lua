-- Journal Assistant - Fishing
--
-- Guide band zone, combined with other zones / fish that Cooking needs.

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, prio, contains, SafetyFactor, CautionText = U.AddTask, U.prio, U.contains, U.SafetyFactor, U.CautionText
local FishZones, BandBonus = PP.FishZones, PP.BandBonus

function PP:AddFishing(ctx, p, target)
    local goal = math.min(target, p.maxSkill)
    if p.skill >= goal then return end
    self:AddLevelGate(ctx, "FISHING", p.name, p.skill)
    local wanted = {}
    for _, lname in ipairs(ctx.demandOrder) do
        local d = ctx.demand[lname]
        if not d.coveredBy and FishZones(d.name) and ns.Inventory:Count(d) < d.need then wanted[#wanted + 1] = d end
    end
    local bestZ, bestS, bestMats
    for zone, minSkill in pairs(ns.Data.fishingZones) do
        if minSkill <= p.skill and ns.Routes:IsAllowed(zone, ctx.level) then
            local s, mats = 1, {}
            s = s + 2.0 * BandBonus("FISHING", p.skill, zone)
            if ctx.gatherZones[zone] then s = s + 1.0 end
            if ctx.rankZones[zone] then s = s + 1.0 end
            if zone == ctx.curZone then s = s + 0.5 end
            for _, d in ipairs(wanted) do
                if contains(FishZones(d.name), zone) then s = s + 0.6; mats[#mats + 1] = d end
            end
            s = s * SafetyFactor(zone, ctx.level) / (1 + 0.15 * ns.Routes:Distance(ctx.curZone, zone))
            if not bestS or s > bestS then bestZ, bestS, bestMats = zone, s, mats end
        end
    end
    if not bestZ then return end
    local id = "fish:" .. bestZ
    local materials = {}
    for _, d in ipairs(bestMats) do
        d.coveredBy = id
        materials[#materials + 1] = { name = d.name, itemID = d.itemID, need = d.need, demand = d }
    end
    local band = ns.Data.RouteBand("FISHING", p.skill)
    local inBand = band and contains(band.zones, bestZ)
    local bandGoal = (inBand and band.to < goal) and band.to or goal
    local perPoint = p.skill < 75 and 1 or (math.floor((p.skill - 75) / 25) + 1)
    local est = (bandGoal - p.skill) * perPoint
    local lines = { ("Fishing %d -> %d: roughly %d catches (estimate; gains slow down as skill rises)."):format(p.skill, bandGoal, est) }
    if inBand and band.note then lines[#lines + 1] = "Forever guide: " .. band.note .. "." end
    for _, d in ipairs(bestMats) do lines[#lines + 1] = ("Keep %d %s for %s"):format(d.need, d.name, table.concat(d.reasons, "; ")) end
    lines[#lines + 1] = ns.Data.tips.FISHING
    local reasons = { "Fishing to " .. bandGoal }
    if ctx.gatherZones[bestZ] then reasons[#reasons + 1] = "same zone as gathering" end
    if ctx.rankZones[bestZ] then reasons[#reasons + 1] = "same zone as a rank unlock / vendor" end
    if #bestMats > 0 then reasons[#reasons + 1] = "Cooking ingredients" end
    local spot = inBand and band.spot and band.spot.zone == bestZ and band.spot or nil
    AddTask(ctx, {
        id = id, kind = "fish", prof = "FISHING",
        title = ("Fish in %s"):format(spot and (spot.label .. ", " .. bestZ) or bestZ) .. (#bestMats > 0 and " (+ Cooking fish)" or ""),
        detail = table.concat(lines, "\n"),
        zone = bestZ, materials = materials, qty = est,
        dest = spot and { zone = bestZ, x = spot.x, y = spot.y, approx = true } or nil,
        caution = CautionText(bestZ, ctx.level), confidence = "forever-guide",
        value = (3 + 0.6 * #bestMats) * prio("FISHING"),
        metric = { skillKey = "FISHING", skillGoal = bandGoal, materials = #materials > 0 },
        reasons = reasons,
    })
    ctx.gatherZones[bestZ] = true
end
