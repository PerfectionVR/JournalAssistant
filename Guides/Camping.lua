-- Journal Assistant - Camping tasks
--
-- Cozy Sleeping Bag chain and the next camp object per profession.

local _, ns = ...
local PL = ns.Planner
local GP = ns.GuidePlan
local U = PL.util
local AddTask, prio = U.AddTask, U.prio

ns.QuestChains:RegisterChains(ns.Data.campingChains)

local function KnowsCampObject(profKey, name)
    local cache = ns.Recipes:Get(profKey)
    if not cache or not cache.list then return nil end -- unknown (not scanned)
    local lname = string.lower(name)
    for _, r in pairs(cache.list) do
        if r.learned and r.name and string.lower(r.name):find(lname, 1, true) then return true end
    end
    return false
end

function GP:AddCamping(ctx)
    if not ns.db.showCamping then return end
    self:AddChainGroup(ctx, ns.QuestChains:ChainsFrom(ns.Data.campingChains), "CAMPING", "", "CAMPING")
    for _, p in ipairs(ns.Professions.list) do
        local objs = (not ns.Professions:IsPaused(p.key)) and (ns.Data.campObjects or {})[p.key] or nil
        if objs then
            for _, o in ipairs(objs) do
                local known = KnowsCampObject(p.key, o.name)
                if not known and p.skill >= o.skill - 20 then
                    local dg = o.dungeon and ns.Data.dungeons[o.dungeon]
                    local zone = dg and dg.zone or nil
                    local blocked
                    if p.skill < o.skill then
                        blocked = ("Reach %s %d (you have %d)"):format(p.name, o.skill, p.skill)
                    elseif dg and dg.level and ctx.level < dg.level then
                        blocked = ("Reach level %d for %s (you are %d)"):format(dg.level, o.dungeon, ctx.level)
                    end
                    local how
                    if o.boss then
                        how = ("Blueprint drops from %s in %s%s."):format(o.boss, o.dungeon,
                            dg and dg.level and (" (recommended level " .. dg.level .. ")") or (dg and " (Forever dungeon, level unknown)" or ""))
                    elseif o.skill <= 20 then
                        how = ("Quest \"Camping 101: %s\" or your %s trainer."):format(p.name, p.name)
                    else
                        how = "Source not confirmed yet."
                    end
                    AddTask(ctx, {
                        id = ("camp:%s:%s"):format(p.key, o.name), kind = "obtain", prof = p.key, group = "CAMPING",
                        title = ("Camp object: %s (%s %d)"):format(o.name, p.name, o.skill),
                        detail = ("Effect: %s.\n%s\n%s%s"):format(o.effect, how, ns.Data.campingTips,
                            known == nil and ("\nOpen your " .. p.name .. " window so JA can see whether you already know it.") or ""),
                        zone = zone, blocked = blocked, confidence = "forever-guide",
                        value = (o.skill <= 20 and 3 or 2) * prio("CAMPING"),
                        reasons = { "camp object for " .. p.name },
                    })
                    break -- only the next tier per profession
                end
            end
        end
    end
end
