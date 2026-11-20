-- Journal Assistant - World data (zones, travel links, hubs, dungeons)
--
-- CONFIDENCE: "classic" = taken from original Classic (1.12) knowledge and NOT
-- verified on WoW: Forever. Level ranges and travel links are used only for
-- safety filtering and route ordering heuristics. Map IDs are never hard-coded:
-- they are resolved at runtime by zone name through C_Map (see Routes.lua).

local _, ns = ...
local D = ns.Data

D.zoneSource = "classic"

-- cont: EK = Eastern Kingdoms, KAL = Kalimdor. city = capital/trainer hub.
-- faction: zone controlled by a faction (hostile guards for the other one).
D.zones = {
    ["Stormwind City"]       = { min = 1,  max = 60, cont = "EK",  city = true, faction = "Alliance" },
    ["Ironforge"]            = { min = 1,  max = 60, cont = "EK",  city = true, faction = "Alliance" },
    ["Darnassus"]            = { min = 1,  max = 60, cont = "KAL", city = true, faction = "Alliance" },
    ["Orgrimmar"]            = { min = 1,  max = 60, cont = "KAL", city = true, faction = "Horde" },
    ["Thunder Bluff"]        = { min = 1,  max = 60, cont = "KAL", city = true, faction = "Horde" },
    ["Undercity"]            = { min = 1,  max = 60, cont = "EK",  city = true, faction = "Horde" },
    ["Moonglade"]            = { min = 1,  max = 60, cont = "KAL", city = true },
    ["Durotar"]              = { min = 1,  max = 10, cont = "KAL" },
    ["Mulgore"]              = { min = 1,  max = 10, cont = "KAL" },
    ["Tirisfal Glades"]      = { min = 1,  max = 10, cont = "EK" },
    ["Silverpine Forest"]    = { min = 10, max = 20, cont = "EK" },
    ["The Barrens"]          = { min = 10, max = 25, cont = "KAL" },
    ["Elwynn Forest"]        = { min = 1,  max = 10, cont = "EK" },
    ["Dun Morogh"]           = { min = 1,  max = 10, cont = "EK" },
    ["Teldrassil"]           = { min = 1,  max = 10, cont = "KAL" },
    ["Westfall"]             = { min = 10, max = 20, cont = "EK" },
    ["Loch Modan"]           = { min = 10, max = 20, cont = "EK" },
    ["Darkshore"]            = { min = 10, max = 20, cont = "KAL" },
    ["Redridge Mountains"]   = { min = 15, max = 25, cont = "EK" },
    ["Stonetalon Mountains"] = { min = 15, max = 27, cont = "KAL" },
    ["Duskwood"]             = { min = 18, max = 30, cont = "EK" },
    ["Ashenvale"]            = { min = 18, max = 30, cont = "KAL" },
    ["Wetlands"]             = { min = 20, max = 30, cont = "EK" },
    ["Hillsbrad Foothills"]  = { min = 20, max = 30, cont = "EK" },
    ["Thousand Needles"]     = { min = 25, max = 35, cont = "KAL" },
    ["Alterac Mountains"]    = { min = 30, max = 40, cont = "EK" },
    ["Arathi Highlands"]     = { min = 30, max = 40, cont = "EK" },
    ["Desolace"]             = { min = 30, max = 40, cont = "KAL" },
    ["Stranglethorn Vale"]   = { min = 30, max = 45, cont = "EK" },
    ["Dustwallow Marsh"]     = { min = 35, max = 45, cont = "KAL" },
    ["Swamp of Sorrows"]     = { min = 35, max = 45, cont = "EK" },
    ["Badlands"]             = { min = 35, max = 45, cont = "EK" },
    ["The Hinterlands"]      = { min = 40, max = 50, cont = "EK" },
    ["Feralas"]              = { min = 40, max = 50, cont = "KAL" },
    ["Tanaris"]              = { min = 40, max = 50, cont = "KAL" },
    ["Searing Gorge"]        = { min = 43, max = 50, cont = "EK" },
    ["Azshara"]              = { min = 45, max = 55, cont = "KAL" },
    ["Blasted Lands"]        = { min = 45, max = 55, cont = "EK" },
    ["Felwood"]              = { min = 48, max = 55, cont = "KAL" },
    ["Un'Goro Crater"]       = { min = 48, max = 55, cont = "KAL" },
    ["Burning Steppes"]      = { min = 50, max = 58, cont = "EK" },
    ["Western Plaguelands"]  = { min = 51, max = 58, cont = "EK" },
    ["Eastern Plaguelands"]  = { min = 53, max = 60, cont = "EK" },
    ["Winterspring"]         = { min = 53, max = 60, cont = "KAL" },
}

-- Travel links (cost 1 = walking border, 2 = boat/tram). Heuristic only.
D.zoneLinks = {
    { "Stormwind City", "Elwynn Forest", 1 },
    { "Stormwind City", "Ironforge", 2 },          -- Deeprun Tram
    { "Elwynn Forest", "Westfall", 1 },
    { "Elwynn Forest", "Redridge Mountains", 1 },
    { "Elwynn Forest", "Duskwood", 1 },
    { "Westfall", "Duskwood", 1 },
    { "Duskwood", "Stranglethorn Vale", 1 },
    { "Duskwood", "Swamp of Sorrows", 2 },         -- through Deadwind Pass
    { "Redridge Mountains", "Burning Steppes", 1 },
    { "Swamp of Sorrows", "Blasted Lands", 1 },
    { "Ironforge", "Dun Morogh", 1 },
    { "Dun Morogh", "Loch Modan", 1 },
    { "Loch Modan", "Wetlands", 1 },
    { "Loch Modan", "Badlands", 1 },
    { "Badlands", "Searing Gorge", 1 },
    { "Searing Gorge", "Burning Steppes", 1 },
    { "Wetlands", "Arathi Highlands", 1 },
    { "Arathi Highlands", "Hillsbrad Foothills", 1 },
    { "Arathi Highlands", "The Hinterlands", 1 },
    { "Hillsbrad Foothills", "Alterac Mountains", 1 },
    { "Hillsbrad Foothills", "The Hinterlands", 1 },
    { "Alterac Mountains", "Western Plaguelands", 1 },
    { "Western Plaguelands", "Eastern Plaguelands", 1 },
    { "Wetlands", "Darkshore", 2 },                 -- Menethil boat
    { "Wetlands", "Dustwallow Marsh", 2 },          -- Menethil - Theramore boat
    { "Stranglethorn Vale", "Tanaris", 3 },         -- via Booty Bay - Ratchet boat
    { "Teldrassil", "Darnassus", 1 },
    { "Teldrassil", "Darkshore", 2 },
    { "Darkshore", "Ashenvale", 1 },
    { "Ashenvale", "Stonetalon Mountains", 1 },
    { "Ashenvale", "Azshara", 1 },
    { "Ashenvale", "Felwood", 1 },
    { "Felwood", "Winterspring", 1 },
    { "Stonetalon Mountains", "Desolace", 1 },
    { "Desolace", "Feralas", 1 },
    { "Feralas", "Thousand Needles", 1 },
    { "Thousand Needles", "Tanaris", 1 },
    { "Tanaris", "Un'Goro Crater", 1 },
    { "Thousand Needles", "Dustwallow Marsh", 2 },  -- through the Barrens
    { "Ashenvale", "The Barrens", 1 },
    { "The Barrens", "Dustwallow Marsh", 1 },
    { "The Barrens", "Thousand Needles", 1 },
    { "The Barrens", "Stonetalon Mountains", 1 },
    { "The Barrens", "Durotar", 1 },
    { "The Barrens", "Mulgore", 1 },
    { "Durotar", "Orgrimmar", 1 },
    { "Mulgore", "Thunder Bluff", 1 },
    { "Tirisfal Glades", "Undercity", 1 },
    { "Tirisfal Glades", "Silverpine Forest", 1 },
    { "Silverpine Forest", "Hillsbrad Foothills", 1 },
    { "Moonglade", "Darnassus", 2 },                -- druid teleport / flight
    { "Moonglade", "Felwood", 1 },
}

-- Preferred hubs (for "buy from vendor / auction house" tasks), by faction.
D.hubs = {
    Alliance = { "Stormwind City", "Ironforge", "Darnassus" },
    Horde = { "Orgrimmar", "Undercity", "Thunder Bluff" },
}

-- Dungeons: entrance zone (for travel) and Classic recommended level
-- (unverified for Forever's new dungeons, marked level = nil).
D.dungeons = {
    ["The Deadmines"] = { zone = "Westfall", level = 18 },
    ["Wailing Caverns"] = { zone = "The Barrens", level = 17 },
    ["Shadowfang Keep"] = { zone = "Silverpine Forest", level = 22 },
    ["Blackfathom Deeps"] = { zone = "Ashenvale", level = 24 },
    ["Scarlet Monastery"] = { zone = "Tirisfal Glades", level = 30 },
    ["Sunken Temple"] = { zone = "Swamp of Sorrows", level = 50 },
    ["Blackrock Depths"] = { zone = "Blackrock Mountain", level = 52 },
    ["Lower Blackrock Spire"] = { zone = "Blackrock Mountain", level = 55 },
    ["Upper Blackrock Spire"] = { zone = "Blackrock Mountain", level = 58 },
    ["Dire Maul"] = { zone = "Feralas", level = 55 },
    ["Scholomance"] = { zone = "Western Plaguelands", level = 58 },
    ["Stratholme"] = { zone = "Eastern Plaguelands", level = 58 },
    -- entrance zones only (levels come from the quest objective's mob level)
    ["Ragefire Chasm"] = { zone = "Orgrimmar" },
    ["The Stockade"] = { zone = "Stormwind City" },
    ["Gnomeregan"] = { zone = "Dun Morogh" },
    ["Razorfen Kraul"] = { zone = "The Barrens" },
    ["Razorfen Downs"] = { zone = "The Barrens" },
    ["Uldaman"] = { zone = "Badlands" },
    ["Zul'Farrak"] = { zone = "Tanaris" },
    ["Maraudon"] = { zone = "Desolace" },
    ["Excavation Site: Wetlands"] = { zone = "Wetlands" },          -- Forever dungeon, level unknown
    ["Ruins of Lordaeron"] = { zone = "Tirisfal Glades" },          -- Forever dungeon, level unknown
    ["Dalaran"] = { zone = "Alterac Mountains" },                    -- Forever dungeon, level unknown
}
