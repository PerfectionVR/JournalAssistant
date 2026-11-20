-- Journal Assistant - Rank (skill cap) tasks
--
-- Trainer / book / quest that raises your cap, with Auction House fallback for
-- tradeable books in dangerous areas, and the "Reach level X" gate tasks.

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, prio, SafetyFactor, CautionText, Hub = U.AddTask, U.prio, U.SafetyFactor, U.CautionText, U.Hub

function PP:AddRank(ctx, p, target)
    local r = ns.Data.NextRank(p.key, p.maxSkill)
    if not r then
        AddTask(ctx, {
            id = "rank:" .. p.key .. ":unknown" .. p.maxSkill, kind = "rank", prof = p.key,
            title = ("Raise %s cap above %d"):format(p.name, p.maxSkill),
            detail = "No information yet on how to raise this cap in WoW: Forever.",
            blocked = "Unknown unlock method", confidence = "unknown", value = 1,
        })
        return
    end
    local sources = ns.Data.RankSourcesFor(r, ctx.faction)
    local best, bestScore
    for _, s in ipairs(sources) do
        local f = SafetyFactor(s.zone, ctx.level, s.area and s.area.min)
        local score = f / (1 + ns.Routes:Distance(ctx.curZone, s.zone))
        if not bestScore or score > bestScore then best, bestScore = s, score end
    end

    local blocked
    if ctx.level < (r.minLevel or 1) then
        blocked = ("Requires character level %d"):format(r.minLevel)
    elseif p.skill < (r.reqSkill or 0) then
        blocked = ("Requires %s %d (you have %d)"):format(p.name, r.reqSkill, p.skill)
    end

    local zone = best and best.zone
    local areaMin, areaName = best and best.area and best.area.min, best and best.area and best.area.name
    local caution, safety, effMin = CautionText(zone, ctx.level, areaMin, areaName)
    local where = best and (best.npc .. ", " .. best.zone .. (best.note and (" (" .. best.note .. ")") or ""))
        or "Location not verified for Forever"
    local capped = p.skill >= p.maxSkill
    local value = (capped and 7 or (p.skill >= p.maxSkill - 15 and 4 or 1.5)) * prio(p.key)
    local reasons = { capped and (p.name .. " is capped: progress is blocked until this is done")
        or ("Needed before " .. p.name .. " can pass " .. p.maxSkill) }

    -- Tradeable unlock item in a dangerous place -> Auction House instead
    if r.tradeable and safety == "danger" and not ns.db.allowDangerous then
        local hub = Hub(ctx)
        AddTask(ctx, {
            id = ("rank:%s:%d:ah"):format(p.key, r.cap), kind = "rank", prof = p.key,
            title = ("Buy %s on the Auction House"):format(r.item),
            detail = ("Raises %s cap %d -> %d. The vendor (%s) is too dangerous at level %d: %s\nThe book is tradeable - buy it at the %s Auction House (or ask a guildmate), then right-click it to learn. Visit the vendor yourself once you reach level %d.")
                :format(p.name, p.maxSkill, r.cap, where, ctx.level, caution or "", hub, effMin or 0),
            zone = hub, blocked = blocked, confidence = r.confidence,
            value = value, metric = { capKey = p.key, capGoal = r.cap },
            materials = { { name = r.item, itemID = r.itemID, need = 1 } },
            reasons = reasons,
        })
        ctx.rankZones[hub] = true
        return
    end

    local title
    if r.method == "book" then
        title = ("Buy & learn %s"):format(r.item or ("Expert " .. p.name))
    elseif r.method == "quest" then
        title = ("%s rank: %s"):format(r.rank, r.item or "quest")
    else
        title = ("Train %s %s"):format(r.rank, p.name)
    end
    if safety == "danger" and not ns.db.allowDangerous and not blocked then
        blocked = ("Reach level %d first (you are %d)"):format(effMin or 0, ctx.level)
    end
    AddTask(ctx, {
        id = ("rank:%s:%d"):format(p.key, r.cap), kind = "rank", prof = p.key,
        title = title,
        detail = ("Raises %s cap %d -> %d. %s.%s"):format(p.name, p.maxSkill, r.cap, where,
            r.note and ("\n" .. r.note) or ""),
        zone = zone,
        dest = best and best.x and { zone = best.zone, x = best.x, y = best.y, npc = best.npc, approx = true } or nil,
        npc = best and best.npc,
        blocked = blocked, caution = caution,
        confidence = r.confidence or "classic",
        value = value,
        metric = { capKey = p.key, capGoal = r.cap },
        reasons = reasons,
    })
    if not blocked then ctx.rankZones[zone or ""] = true end
end


---------------------------------------------------------------------------
-- Level gate: the Forever guide zone for this skill band is above your level.
-- Shown under "Requirements not met yet" with the recommended level; the
-- alternatives (safe-zone task, buying materials, other professions) are
-- filled in by Build() once the whole plan is known.
---------------------------------------------------------------------------
function PP:AddLevelGate(ctx, key, profName, skill)
    local band = ns.Data.RouteBand and ns.Data.RouteBand(key, skill)
    if not band then return end
    local rec, recZone, recInfo
    for _, z in ipairs(band.zones) do
        local info = ns.Data.zones[z]
        if info and not info.city then
            if not rec or info.min < rec then rec, recZone, recInfo = info.min, z, info end
        else
            return -- a city / unknown-level zone in the band: no gate
        end
    end
    if not rec or ctx.level >= rec then return end
    AddTask(ctx, {
        id = ("gate:%s:%d"):format(key, band.from), kind = "info", prof = key, gate = true,
        title = ("Reach level %d: %s %d-%d guide route (%s)"):format(rec, profName, band.from, band.to, recZone),
        detail = ("Forever guides level %s %d-%d in %s. The easiest of these, %s, has level %d-%d mobs - you are level %d.")
            :format(profName, band.from, band.to, table.concat(band.zones, " / "), recZone, recInfo.min, recInfo.max, ctx.level),
        blocked = ("Reach level %d (you are %d)"):format(rec, ctx.level),
        confidence = "forever-guide", value = 9,
        gateLevel = rec,
    })
end
