-- Journal Assistant - Library Books (WoW: Forever)
--
-- Compiled 2026-11-20 from Warcraft Tavern, Method.gg (8 Nov) and ConquestCapped.
-- Coordinates: Warcraft Tavern value unless Method and ConquestCapped agree on
-- a different one. Item IDs from the guides' item links. `area` = dangerous
-- spot level inside an easier zone. `alt` = a second spawn of the same book
-- (only one copy counts). Guides list 36-39 books; all 39 known are here.

local _, ns = ...
local D = ns.Data

-- Blackrock Mountain books sit outside the instance portals
D.zones["Blackrock Mountain"] = D.zones["Blackrock Mountain"] or { min = 50, max = 58, cont = "EK" }

local function b(item, name, zone, x, y, note, extra)
    local t = { item = item, name = name, zone = zone, x = x, y = y, note = note }
    if extra then for k, v in pairs(extra) do t[k] = v end end
    return t
end

D.books = {
    b(203755, "Archmage Theocritus' Research Journal", "Elwynn Forest", 65.4, 70.1, "Tower of Azora, table upstairs", { faction = "Alliance" }),
    b(203754, "Archmage Antonidas: The Unabridged Autobiography", "Ironforge", 76.1, 10.2, "Hall of Explorers, large table", { faction = "Alliance" }),
    b(208860, "Rumi of Gnomeregan: The Collected Works", "Westfall", 52.7, 53.8, "Sentinel Hill inn, table behind the innkeeper",
        { alt = { zone = "Loch Modan", x = 35.6, y = 48.9, note = "Thelsamar inn, upstairs" } }),
    b(209845, "Bewitchments and Glamours", "Westfall", 45.4, 70.5, "Moonbrook, first house from the east"),
    b(209849, "Crimes Against Anatomy", "Duskwood", 16.7, 28.5, "Raven Hill crypt, westernmost entrance, end of the stairs"),
    b(209850, "Runes of the Sorcerer-Kings", "Loch Modan", 77.5, 14.1, "Mo'grosh Stronghold ogre cave, left path past two ogres"),
    b(209848, "Goaz Scrolls", "Wetlands", 33.6, 47.9, "Whelgar's Excavation Site, lowest level (urn)"),
    b(208185, "The Apothecary's Metaphysical Primer", "Tirisfal Glades", 59.5, 52.3, "Brill alchemy shop (Horde town)", { hostileFor = "Alliance" }),
    b(210177, "Ataeric: On Arcane Curiosities", "Silverpine Forest", 43.4, 41.2, "The Sepulcher, table near Sebastian Meloche", { faction = "Horde" }),
    b(209844, "The Dalaran Digest, Vol. 23", "Silverpine Forest", 63.5, 63.1, "Amber Mill main hall, bookshelf"),
    b(209847, "Arcanic Systems Manual", "The Barrens", 56.3, 8.8, "Sludge Fen oil rig, top control room, chair"),
    b(208800, "Baxtan: On Destructive Magics", "The Barrens", 62.7, 36.3, "Ratchet engineering building, table near Gazlowe"),
    b(209846, "Secrets of the Dreamers", "The Barrens", 46.0, 36.4, "Cavern of Mists via the cave at Lushwater Oasis (NOT Wailing Caverns); book in the final room"),
    b(209843, "Nar'thalas Almanac, Vol. 74", "Darkshore", 59.6, 22.2, "Ruins of Mathystra, down the stairs before the flooded floor"),
    b(209851, "Fury of the Land", "Stonetalon Mountains", 74.4, 85.7, "Grimtotem Post, tent by the eastern totem, barrel"),
    b(207972, "The Lessons of Ta'zo", "Orgrimmar", 38.6, 78.4, "Tablet before the Darkbriar Lodge sign", { faction = "Horde" }),
    b(213165, "Basilisks: Should Petrification be Feared?", "Stranglethorn Vale", 41.5, 50.8, "Large table outside the basilisk cave (path from 37.1, 48.8)"),
    b(215683, "Geomancy: The Stone-Cold Truth", "Thousand Needles", 34.0, 40.0, "Darkcloud Pinnacle, largest hut (climb from 31, 37)"),
    b(215815, "Defensive Magics 101", "Alterac Mountains", 48.5, 57.6, "Ogre tower at the crossroads; level 40 ogre guards the room", { area = 40 }),
    b(215816, "A Web of Lies: Debunking Myths and Legends", "Arathi Highlands", 73.0, 65.0, "Witherbark Village, east hut"),
    b(215820, "Mummies: A Guide to the Unsavory Undead", "Badlands", 57.0, 39.0, "Crypt above the dwarf camp (climb from 56, 45)"),
    b(215822, "RwlRwlRwlRwl!", "Dustwallow Marsh", 57.0, 21.0, "Witch Hill murloc camp, east edge"),
    b(215817, "Demons and You", "Desolace", 55.1, 26.2, "Thunder Axe Fortress, large inner building, bench"),
    b(215824, "A Luddite's Guide to Caring for Your Demonic Pet", "Swamp of Sorrows", 61.0, 22.0, "Fallow Sanctuary, caged - needs a Rusted Cage Key"),
    b(220345, "Sanguine Sorcery", "Swamp of Sorrows", 70.1, 51.8, "Temple of Atal'Hakkar, top level, back side"),
    b(220353, "Conjurer's Codex", "Blasted Lands", 55.3, 32.2, "Rubble along the road between Dreadmaul Hold and Nethergarde"),
    b(220349, "Stonewrought Design", "Blackrock Mountain", 31.1, 30.1, "Central vault, one floor down, by Franclorn Forgewright's tomb"),
    b(228133, "Magma or Lava?", "Blackrock Mountain", 31.1, 30.1, "Past the summoning stone and Lothos Riftwaker"),
    b(220352, "A Mind of Metal", "Searing Gorge", 37.8, 49.6, "Tent with a Dark Iron dwarf"),
    b(220350, "Venomous Journeys", "The Hinterlands", 36.0, 72.7, "Shadra'Alor, first pyramid on the left"),
    b(228141, "Necromancy 101", "Western Plaguelands", 69.4, 72.5, "Caer Darrow, Scholomance building upstairs (stay outside the instance)"),
    b(228132, "Undead Potatoes", "Western Plaguelands", 38.3, 54.6, "Felstone Field farmhouse, upstairs table"),
    b(228135, "A Study of the Light", "Eastern Plaguelands", 71.8, 48.2, "Light's Hope Chapel, back left"),
    b(228140, "Scourge: Undead Menace or Misunderstood?", "Eastern Plaguelands", 26.5, 14.5, "Table by the gibbets before the Stratholme bridge"),
    b(228138, "The Knight and the Lady", "Eastern Plaguelands", 47.3, 42.3, "Burnt house east of Blackwood Lake"),
    b(220348, "Everyday Etiquette", "Azshara", 20.4, 62.3, "Haldarr Encampment, crate by a hut"),
    b(220346, "Legends of the Tidesages", "Tanaris", 72.6, 47.8, "Lost Rigger Cove, middle building, bookshelf"),
    b(228134, "Northern Kalimdor - A Comprehensive Guide", "Felwood", 65.2, 3.2, "Timbermaw Hold cave, about halfway, by the bridge"),
    b(228136, "Ka-Boom!", "Winterspring", 61.0, 38.0, "Everlook alchemy shop shelf"),
}

D.librarians = {
    Alliance = { npc = "Garion Wendell", zone = "Stormwind City", x = 49.0, y = 86.3, note = "top of the Wizard's Sanctum tower, Mage Quarter" },
    Horde = { npc = "Owen Thadd", zone = "Undercity", x = 74.0, y = 32.5, note = "inner Magic Quarter" },
}

-- Milestone reward quests (books turned in are cumulative)
D.bookMilestones = {
    { books = 10, level = 1,  quest = 78150, title = "Friend of the Library", reward = "Scholarly Pendant or Erudite's Amulet" },
    { books = 20, level = 20, quest = 79536, title = "Greater Friend of the Library", reward = "Field Researcher's Loop or Philanthropist's Ring" },
    { books = 25, level = 35, quest = 82208, title = "Greater Friend of the Library", reward = "Truthseeker's Bow, Crest of Elucidation or Researcher's Night Light",
      note = "Method says level 30; Warcraft Tavern / Wowhead 35" },
    { books = 35, level = 50, quest = 84394, title = "Greater Friend of the Library", reward = "Antique Bulwark, Artifact Seeker's Pendant or Museum Keeper's Chain",
      note = "only listed by Warcraft Tavern" },
}
