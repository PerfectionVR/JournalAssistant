-- Journal Assistant - Mining data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Mining. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("MINING", { name = "Mining", skillLine = 186, kind = "gather", order = 2,
    icon = "Interface\\Icons\\Trade_Mining" })

D.trainers.MINING = {
    src("Gelman Stonehand", "Stormwind City", "Alliance", 59.2, 37.8),
    src("Geofram Bouldertoe", "Ironforge", "Alliance", 50.2, 26.1),
    src("Brock Stoneseeker", "Loch Modan", "Alliance", 37.2, 47.8, { note = "Thelsamar" }),
    src("Kurdram Stonehammer", "Darkshore", "Alliance", 38.2, 41.0, { note = "Auberdine" }),
    src("Makaru", "Orgrimmar", "Horde"),
}

D.ranks.MINING = standard("MINING", { noLevel = true })

D.routeBands.MINING = {
    { from = 1,   to = 65,  zones = { "Elwynn Forest", "Dun Morogh", "Westfall", "Loch Modan" } },
    { from = 65,  to = 125, zones = { "Wetlands", "Loch Modan", "Duskwood" }, note = "Wetlands caves" },
    { from = 125, to = 175, zones = { "Arathi Highlands", "Alterac Mountains", "Thousand Needles" } },
    { from = 175, to = 245, zones = { "The Hinterlands", "Badlands", "Tanaris", "Alterac Mountains" } },
    { from = 245, to = 275, zones = { "Un'Goro Crater", "Blasted Lands", "Felwood", "Swamp of Sorrows" } },
    { from = 275, to = 300, zones = { "Winterspring", "Eastern Plaguelands", "Un'Goro Crater", "Burning Steppes" } },
}

D.tips.MINING = "Smelt as you go: smelting also gives skill until the bar turns grey. Ores stack to 20 in Forever."

---------------------------------------------------------------------------
-- Mining nodes (skill requirements confirmed unchanged in Forever).
-- `items` are what the node and smelting produce, used to match crafting demand.
---------------------------------------------------------------------------
D.ores = {
    { name = "Copper Vein", skill = 1, items = { "Copper Ore", "Rough Stone", "Copper Bar" },
      zones = { "Elwynn Forest", "Dun Morogh", "Westfall", "Loch Modan", "Redridge Mountains", "Darkshore", "Duskwood", "Wetlands" } },
    { name = "Tin Vein", skill = 65, items = { "Tin Ore", "Coarse Stone", "Tin Bar", "Bronze Bar" },
      zones = { "Wetlands", "Duskwood", "Loch Modan", "Redridge Mountains", "Hillsbrad Foothills", "Ashenvale", "Stonetalon Mountains", "Arathi Highlands", "Stranglethorn Vale" } },
    { name = "Silver Vein", skill = 75, items = { "Silver Ore", "Silver Bar" },
      zones = { "Arathi Highlands", "Alterac Mountains", "Stranglethorn Vale", "Wetlands", "Duskwood", "Hillsbrad Foothills" } },
    { name = "Iron Deposit", skill = 125, items = { "Iron Ore", "Heavy Stone", "Iron Bar", "Steel Bar" },
      zones = { "Arathi Highlands", "Alterac Mountains", "Stranglethorn Vale", "Hillsbrad Foothills", "Desolace", "Thousand Needles", "Badlands", "Swamp of Sorrows", "Dustwallow Marsh" } },
    { name = "Gold Vein", skill = 155, items = { "Gold Ore", "Gold Bar" },
      zones = { "Arathi Highlands", "Alterac Mountains", "Stranglethorn Vale", "Badlands", "Desolace", "Swamp of Sorrows", "Thousand Needles" } },
    { name = "Mithril Deposit", skill = 175, items = { "Mithril Ore", "Solid Stone", "Mithril Bar" },
      zones = { "Badlands", "The Hinterlands", "Alterac Mountains", "Searing Gorge", "Tanaris", "Feralas", "Swamp of Sorrows", "Stranglethorn Vale", "Desolace" } },
    { name = "Truesilver Deposit", skill = 230, items = { "Truesilver Ore", "Truesilver Bar" },
      zones = { "Badlands", "The Hinterlands", "Alterac Mountains", "Searing Gorge", "Tanaris", "Feralas", "Un'Goro Crater", "Burning Steppes" } },
    { name = "Dark Iron Deposit", skill = 230, items = { "Dark Iron Ore", "Dark Iron Bar" },
      zones = { "Searing Gorge", "Burning Steppes" } },
    { name = "Small Thorium Vein", skill = 245, items = { "Thorium Ore", "Dense Stone", "Thorium Bar" },
      zones = { "Swamp of Sorrows", "Blasted Lands", "Winterspring", "Un'Goro Crater", "Searing Gorge", "Burning Steppes", "Felwood", "Tanaris", "The Hinterlands", "Azshara" } },
    { name = "Rich Thorium Vein", skill = 275, items = { "Thorium Ore", "Dense Stone", "Thorium Bar", "Pitchblende" },
      zones = { "Winterspring", "Azshara", "Un'Goro Crater", "Eastern Plaguelands", "Burning Steppes" } },
}
