-- Journal Assistant - Herbalism data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Herbalism. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("HERBALISM", { name = "Herbalism", skillLine = 182, kind = "gather", order = 1,
    icon = "Interface\\Icons\\Trade_Herbalism", aliases = { "gardening", "herb gathering" } })

D.trainers.HERBALISM = {
    src("Tannysa", "Stormwind City", "Alliance", 54.4, 84.0, { note = "Mage Quarter, outside Alchemy Needs" }),
    src("Reyna Stonebranch", "Ironforge", "Alliance", 55.7, 59.0, { note = "Great Forge, Ironforge Physician" }),
    src("Kali Healtouch", "Loch Modan", "Alliance", 36.5, 48.3, { note = "Thelsamar" }),
    src("Alma Jainrose", "Redridge Mountains", "Alliance", 16.7, 45.7, { note = "Lakeshire" }),
    src("Telurinon Moonshadow", "Wetlands", "Alliance", 8.1, 56.0, { note = "Menethil Harbor" }),
    src("Cylania Rootstalker", "Ashenvale", "Alliance", 50.6, 67.2, { note = "Silverwind Refuge" }),
    src("Jandi", "Orgrimmar", "Horde"),
}

D.ranks.HERBALISM = standard("HERBALISM", { noLevel = true,
    artisan = {
        src("Alma Jainrose", "Redridge Mountains", "Alliance", 16.7, 45.7, { note = "Lakeshire" }),
        src("Kali Healtouch", "Loch Modan", "Alliance", 36.5, 48.3, { note = "Thelsamar" }),
        src("Brant Jasperbloom", "Dustwallow Marsh", "Alliance", 64.0, 47.6, { note = "Theramore Isle" }),
    },
    artisanNote = "Some guides list level 25-35 for Artisan; wow-professions says no level requirement." })

D.routeBands.HERBALISM = {
    { from = 1,   to = 70,  zones = { "Elwynn Forest", "Teldrassil", "Dun Morogh" } },
    { from = 70,  to = 115, zones = { "Loch Modan", "Darkshore", "Westfall" } },
    { from = 115, to = 170, zones = { "Wetlands", "Hillsbrad Foothills", "Stonetalon Mountains" },
      note = "Wetlands loop starting at Menethil Harbor" },
    { from = 170, to = 205, zones = { "Arathi Highlands", "Stranglethorn Vale" } },
    { from = 205, to = 230, zones = { "Tanaris", "Searing Gorge" }, note = "Learn Artisan first" },
    { from = 230, to = 270, zones = { "The Hinterlands", "Feralas" } },
    { from = 270, to = 300, zones = { "Felwood", "Eastern Plaguelands", "Winterspring" } },
}

D.herbSource = "forever-guide" -- Timesaver (verified Nov 8 2026): all 28 herb skill levels unchanged from Classic

D.herbs = {
    { name = "Peacebloom",        skill = 1,   zones = { "Elwynn Forest", "Dun Morogh", "Teldrassil", "Westfall", "Loch Modan", "Darkshore" } },
    { name = "Silverleaf",        skill = 1,   zones = { "Elwynn Forest", "Dun Morogh", "Teldrassil", "Westfall", "Loch Modan", "Darkshore" } },
    { name = "Earthroot",         skill = 15,  zones = { "Elwynn Forest", "Dun Morogh", "Westfall", "Loch Modan", "Darkshore", "Redridge Mountains" } },
    { name = "Mageroyal",         skill = 50,  zones = { "Westfall", "Loch Modan", "Darkshore", "Redridge Mountains", "Wetlands", "Stonetalon Mountains" } },
    { name = "Briarthorn",        skill = 70,  zones = { "Darkshore", "Loch Modan", "Redridge Mountains", "Duskwood", "Wetlands", "Ashenvale", "Hillsbrad Foothills" } },
    { name = "Stranglekelp",      skill = 85,  zones = { "Westfall", "Darkshore", "Wetlands", "Hillsbrad Foothills", "Stranglethorn Vale", "Arathi Highlands", "Desolace" } },
    { name = "Bruiseweed",        skill = 100, zones = { "Redridge Mountains", "Duskwood", "Wetlands", "Ashenvale", "Hillsbrad Foothills", "Stonetalon Mountains" } },
    { name = "Wild Steelbloom",   skill = 115, zones = { "Duskwood", "Wetlands", "Hillsbrad Foothills", "Arathi Highlands", "Stonetalon Mountains", "Thousand Needles", "Stranglethorn Vale", "Badlands" } },
    { name = "Grave Moss",        skill = 120, zones = { "Duskwood", "Wetlands", "Desolace" } },
    { name = "Kingsblood",        skill = 125, zones = { "Duskwood", "Wetlands", "Hillsbrad Foothills", "Ashenvale", "Arathi Highlands", "Stranglethorn Vale", "Stonetalon Mountains", "Swamp of Sorrows" } },
    { name = "Liferoot",          skill = 150, zones = { "Wetlands", "Hillsbrad Foothills", "Arathi Highlands", "Stranglethorn Vale", "Swamp of Sorrows", "Dustwallow Marsh" } },
    { name = "Fadeleaf",          skill = 160, zones = { "Arathi Highlands", "Stranglethorn Vale", "Swamp of Sorrows", "Dustwallow Marsh", "Alterac Mountains" } },
    { name = "Goldthorn",         skill = 170, zones = { "Arathi Highlands", "Stranglethorn Vale", "Dustwallow Marsh", "Swamp of Sorrows", "Badlands", "Alterac Mountains", "Feralas" } },
    { name = "Khadgar's Whisker", skill = 185, zones = { "Arathi Highlands", "Stranglethorn Vale", "Dustwallow Marsh", "Swamp of Sorrows", "Alterac Mountains", "The Hinterlands" } },
    { name = "Wintersbite",       skill = 195, zones = { "Alterac Mountains" } },
    { name = "Firebloom",         skill = 205, zones = { "Badlands", "Searing Gorge", "Blasted Lands", "Tanaris" } },
    { name = "Purple Lotus",      skill = 210, zones = { "Stranglethorn Vale", "The Hinterlands", "Feralas", "Tanaris", "Azshara" } },
    { name = "Arthas' Tears",     skill = 220, zones = { "Western Plaguelands", "Eastern Plaguelands", "Felwood" } },
    { name = "Sungrass",          skill = 230, zones = { "The Hinterlands", "Feralas", "Azshara", "Felwood", "Un'Goro Crater", "Blasted Lands" } },
    { name = "Blindweed",         skill = 235, zones = { "Swamp of Sorrows", "Un'Goro Crater" } },
    { name = "Ghost Mushroom",    skill = 245, zones = { "The Hinterlands", "Western Plaguelands" } },
    { name = "Gromsblood",        skill = 250, zones = { "Felwood", "Blasted Lands", "Desolace" } },
    { name = "Golden Sansam",     skill = 260, zones = { "Feralas", "The Hinterlands", "Un'Goro Crater", "Azshara", "Felwood", "Burning Steppes" } },
    { name = "Dreamfoil",         skill = 270, zones = { "Un'Goro Crater", "Azshara", "Felwood", "Western Plaguelands", "Eastern Plaguelands", "Burning Steppes" } },
    { name = "Mountain Silversage", skill = 280, zones = { "Winterspring", "Un'Goro Crater", "Western Plaguelands", "Eastern Plaguelands", "Burning Steppes" } },
    { name = "Plaguebloom",       skill = 285, zones = { "Felwood", "Western Plaguelands", "Eastern Plaguelands" } },
    { name = "Icecap",            skill = 290, zones = { "Winterspring" } },
}

-- Herbs reported as NEW in WoW: Forever (guides, Nov 2026). Skill requirements
-- and zones are unknown, so the planner lists them but never routes to them.
D.foreverHerbs = { "Marefoil", "Demonsage", "Death Lotus" } -- Death Lotus: any herb in Mount Hyjal with the Lotus Claw glove enchant
