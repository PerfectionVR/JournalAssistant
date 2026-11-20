-- Journal Assistant - Skinning
--
-- Guide route band zone that is safe for your level (you skin what you kill).

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, prio, contains, SafetyFactor, CautionText = U.AddTask, U.prio, U.contains, U.SafetyFactor, U.CautionText

function PP:AddSkinning(ctx, p, target)
    local goal = math.min(target, p.maxSkill)
    if p.skill >= goal then return end
    self:AddLevelGate(ctx, "SKINNING", p.name, p.skill)
    local band = ns.Data.RouteBand("SKINNING", p.skill)
    local bestZ, bestS
    local function consider(zone, base)
        if not ns.Routes:IsAllowed(zone, ctx.level) then return end
        local s = base
        if ctx.gatherZones[zone] then s = s + 0.8 end
        if ctx.rankZones[zone] then s = s + 0.5 end
        if zone == ctx.curZone then s = s + 0.5 end
        s = s * SafetyFactor(zone, ctx.level) / (1 + 0.15 * ns.Routes:Distance(ctx.curZone, zone))
        if not bestS or s > bestS then bestZ, bestS = zone, s end
    end
    if band then
        for i, z in ipairs(band.zones) do consider(z, i == 1 and 2 or 1.6) end
    end
    if not bestZ then
        -- fallback: any safe zone whose top mob level still gives skill (mob level ~ skill/5)
        local want = math.floor(p.skill / 5)
        for zone, z in pairs(ns.Data.zones) do
            if not z.city and z.max >= want - 2 then consider(zone, 1) end
        end
    end
    local bandGoal = band and math.min(goal, band.to) or goal
    if not bestZ then
        AddTask(ctx, {
            id = "skin:none", kind = "gather", prof = "SKINNING",
            title = "No safe skinning zone at your level",
            detail = ("Beasts that still give skill at %d are around level %d+."):format(p.skill, math.floor(p.skill / 5)),
            blocked = "No zone safe for your level", confidence = "forever-guide", value = 1,
        })
        return
    end
    local inBand = band and contains(band.zones, bestZ)
    AddTask(ctx, {
        id = "skin:" .. bestZ, kind = "gather", prof = "SKINNING",
        title = ("Skin beasts in %s"):format(bestZ),
        detail = ("Skinning %d -> %d.%s\n%s"):format(p.skill, bandGoal,
            (inBand and band.note) and (" " .. band.note .. ".") or
            (band and (" Guide zones for %d-%d (%s) are not safe at your level."):format(band.from, band.to, table.concat(band.zones, " / ")) or ""),
            ns.Data.tips.SKINNING),
        zone = bestZ, qty = math.ceil((bandGoal - p.skill) * 1.3),
        caution = CautionText(bestZ, ctx.level), confidence = "forever-guide",
        value = 2.5 * prio("SKINNING"),
        metric = { skillKey = "SKINNING", skillGoal = bandGoal },
        reasons = { "Skinning to " .. bandGoal },
    })
    ctx.gatherZones[bestZ] = true
end
