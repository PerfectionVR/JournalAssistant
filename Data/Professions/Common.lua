-- Journal Assistant - Shared profession data helpers
--
-- Loaded before the per-profession files (Data/Professions/<Name>.lua), which
-- fill the tables below with their own entries.
--
-- Rank unlocks (Nov 2026 Forever guides): every profession has Apprentice 1-75,
-- Journeyman 75-150 (skill 50), Expert 150-225 (skill 125), Artisan 225-300
-- (skill 200 for primary professions, 225 for secondary quests). Herbalism,
-- Mining and Skinning have no character-level requirement in Forever
-- (wow-professions); other crafting ranks need level 10 / 20 / 35.
-- Coordinates are guide values (0-100). confidence: "forever-guide" = from
-- Forever guides, "classic" = Classic knowledge only. `area` marks a dangerous
-- spot inside an otherwise easier zone (used for safety), `tradeable` = the
-- unlock item can be bought on the Auction House. The planner never relies on
-- these tables for your CAP: that comes from the client.
--
-- Guide data was compiled 2026-11-20 from Forever-specific guides (Alliance
-- side): Wowhead "Tried & Tested" leveling guides (Nov 3-4 2026), Method.gg
-- (Nov 3-15), wow-professions.com/forever (beta-based), Warcraft Tavern,
-- Timesaver.gg (herb/ore/trainer data "last verified Nov 8 2026"),
-- ConquestCapped (Nov 16-18). Herb and ore skill requirements were confirmed
-- unchanged from Classic. Where guides disagree, the most recent
-- Forever-tested source is used and the alternative is listed second.

local _, ns = ...
local D = ns.Data

D.guideSource = "Forever guides (Wowhead, Method, wow-professions, Timesaver), Nov 2026"

-- Per-profession tables, keyed by profession key (ALCHEMY, FIRSTAID, ...)
D.professionInfo = {} -- { name, skillLine, kind = craft|gather|fish, order, icon, aliases }
D.trainers = {}       -- city / town trainers for the regular ranks
D.ranks = {}          -- rank unlocks: trainer, book or quest
D.routeBands = {}     -- gathering / fishing / skinning: skill range -> preferred zones
D.guideRecipes = {}   -- { from, to, recipe name } guide steps
D.recipeVendors = {}  -- recipes you have to buy / farm on the guide route
D.tips = {}           -- one-line advice
D.recipeTeachers = {} -- [lower(recipe)] = generated Wowhead data (Data/Professions/Recipes/)

function D.AddProfession(key, info)
    info.key = key
    D.professionInfo[key] = info
end

D.RANK_NAMES = {
    { cap = 75,  name = "Apprentice" },
    { cap = 150, name = "Journeyman" },
    { cap = 225, name = "Expert" },
    { cap = 300, name = "Artisan" },
}

function D.RankName(maxSkill)
    maxSkill = maxSkill or 0
    for _, r in ipairs(D.RANK_NAMES) do
        if maxSkill <= r.cap then return r.name end
    end
    return "Artisan+"
end

-- A trainer / vendor / quest NPC entry
function D.TrainerSource(npc, zone, faction, x, y, extra)
    local s = { npc = npc, zone = zone, faction = faction, x = x, y = y, approx = true }
    if extra then for k, v in pairs(extra) do s[k] = v end end
    return s
end

-- Standard trainer ranks; `artisan` / `expert` override the trainer list.
-- Call it after D.trainers[key] is set.
function D.StandardRanks(key, opts)
    opts = opts or {}
    local lvl = opts.noLevel and { 1, 1, 1 } or { 10, 20, 35 }
    local conf = opts.confidence or "forever-guide"
    local trainers = D.trainers[key]
    return {
        { rank = "Journeyman", fromCap = 75, cap = 150, reqSkill = 50, minLevel = lvl[1], method = "trainer",
          sources = trainers, confidence = conf },
        { rank = "Expert", fromCap = 150, cap = 225, reqSkill = 125, minLevel = lvl[2], method = "trainer",
          sources = opts.expert or trainers, confidence = conf },
        { rank = "Artisan", fromCap = 225, cap = 300, reqSkill = 200, minLevel = lvl[3], method = "trainer",
          sources = opts.artisan or trainers, confidence = opts.artisanConfidence or conf, note = opts.artisanNote },
    }
end

-- Return the unlock that raises `maxSkill`.
function D.NextRank(profKey, maxSkill)
    local list = D.ranks[profKey]
    if not list then return nil end
    for _, r in ipairs(list) do
        if (maxSkill or 0) < r.cap and (maxSkill or 0) >= r.fromCap then
            return r
        end
    end
    return nil
end

function D.RankSourcesFor(rank, faction)
    local out = {}
    if not rank or not rank.sources then return out end
    for _, s in ipairs(rank.sources) do
        if not s.faction or s.faction == faction then out[#out + 1] = s end
    end
    return out
end

-- Route band for a skill value (first zone = most recommended)
function D.RouteBand(profKey, skill)
    local bands = D.routeBands[profKey]
    if not bands then return nil end
    for _, b in ipairs(bands) do
        if skill >= b.from and skill < b.to then return b end
    end
    return bands[#bands]
end

-- Guide step(s) for a skill value: returns { [lowercase recipe name] = step }, first step
function D.GuideStepsAt(profKey, skill)
    local out, first = {}, nil
    for _, s in ipairs(D.guideRecipes[profKey] or {}) do
        if skill >= s[1] and skill < s[2] then
            out[string.lower(s[3])] = s
            first = first or s
        end
    end
    return out, first
end

-- Reagent name fragments that are normally sold by profession supply vendors.
D.vendorReagentPatterns = {
    "Vial", "Mild Spices", "Hot Spices", "Soothing Spices", "Flour", "Salt",
    "Thread", "Ice Cold Milk", "Refreshing Spring Water", "Simple Flour", "Melon Juice",
}
