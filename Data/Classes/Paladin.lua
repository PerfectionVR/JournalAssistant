-- Journal Assistant - Paladin class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q = D.QuestStep

-- Quest IDs, step order (Wowhead "Series"), quest givers, races and
-- prerequisites from wowhead.com/forever/quest=ID, checked 2026-11-21.
-- "Requires In Progress" quests (The Symbol of Life, Manna-Enriched Horse
-- Feed) sit before the quest they need in your log, since you turn them in first.
local SYMBOL = "Accept the next Tome of Divinity first: The Symbol of Life opens when you do."

D.classQuests.PALADIN = {
    -- level 12: Redemption
    { key = "pal12", level = 12, faction = "Alliance", races = { "Human" },
      title = "Redemption (The Tome of Divinity)", reward = "Redemption", spell = 7328,
      steps = { q(1641, "The Tome of Divinity"), q(1642, "The Tome of Divinity"), q(1643, "The Tome of Divinity"),
                q(1644, "The Tome of Divinity"), q(1780, "The Tome of Divinity"), q(1781, "The Tome of Divinity"),
                { id = 1790, name = "The Symbol of Life", note = SYMBOL },
                q(1786, "The Tome of Divinity"), q(1787, "The Tome of Divinity"), q(1788, "The Tome of Divinity") },
      start = { npc = "Duthorian Rall", zone = "Stormwind City", note = "Cathedral of Light" },
      zones = { "Elwynn Forest" }, confidence = "forever-guide" },
    { key = "pal12d", level = 12, faction = "Alliance", races = { "Dwarf" },
      title = "Redemption (The Tome of Divinity)", reward = "Redemption", spell = 7328,
      steps = { q(1645, "The Tome of Divinity"), q(1646, "The Tome of Divinity"), q(1647, "The Tome of Divinity"),
                q(1648, "The Tome of Divinity"), q(1778, "The Tome of Divinity"), q(1779, "The Tome of Divinity"),
                { id = 1789, name = "The Symbol of Life", note = SYMBOL },
                q(1783, "The Tome of Divinity"), q(1784, "The Tome of Divinity"), q(1785, "The Tome of Divinity") },
      start = { npc = "Tiza Battleforge", zone = "Ironforge", note = "Hall of Mysteries" },
      zones = { "Dun Morogh" }, confidence = "forever-guide" },
    { key = "pal12h", level = 12, faction = "Horde",
      title = "Redemption (A Lesson in Divinity)", reward = "Redemption", spell = 7328,
      steps = { q(94427, "A Lesson in Divinity"), q(94434, "A Lesson in Divinity"), q(94435, "A Lesson in Divinity"),
                q(94436, "A Lesson in Divinity"), q(94438, "A Lesson in Divinity"), q(94440, "A Lesson in Divinity"),
                q(94441, "A Lesson in Divinity") },
      start = { npc = "Danitha Morr", zone = "Tirisfal Glades" }, zones = { "Undercity" }, confidence = "forever-guide" },
    -- level 20: Verigan's Fist
    { key = "pal20", level = 20, faction = "Alliance", races = { "Human" },
      title = "Verigan's Fist", reward = "Verigan's Fist (two-hand mace)",
      steps = { q(1793, "The Tome of Valor"), q(1649, "The Tome of Valor"), q(1650, "The Tome of Valor"), q(1651, "The Tome of Valor"),
                q(1652, "The Tome of Valor"), q(1653, "The Test of Righteousness"), q(1654, "The Test of Righteousness"),
                q(1806, "The Test of Righteousness") },
      start = { npc = "Duthorian Rall", zone = "Stormwind City", note = "Cathedral of Light" },
      zones = { "Westfall", "Dun Morogh", "The Deadmines" }, confidence = "forever-guide" },
    { key = "pal20d", level = 20, faction = "Alliance", races = { "Dwarf" },
      title = "Verigan's Fist", reward = "Verigan's Fist (two-hand mace)",
      steps = { q(1794, "The Tome of Valor"), q(1649, "The Tome of Valor"), q(1650, "The Tome of Valor"), q(1651, "The Tome of Valor"),
                q(1652, "The Tome of Valor"), q(1653, "The Test of Righteousness"), q(1654, "The Test of Righteousness"),
                q(1806, "The Test of Righteousness") },
      start = { npc = "Tiza Battleforge", zone = "Ironforge" },
      zones = { "Stormwind City", "Westfall", "Dun Morogh", "The Deadmines" }, confidence = "forever-guide" },
    -- 1654 "Unlocks" Bailor's Ore Shipment (side quest of the Test of Righteousness)
    { key = "pal22ore", level = 20, faction = "Alliance", optional = true,
      title = "Bailor's Ore Shipment", reward = "see the quest on Wowhead",
      steps = { q(1655, "Bailor's Ore Shipment") }, start = { npc = "Bailor Stonehand", zone = "Loch Modan" },
      confidence = "forever-guide" },
    { key = "pal22h", level = 18, faction = "Horde",
      title = "The Moonsilver Blade", reward = "Moonsilver Blade",
      steps = { q(91858, "Diplomatic Incident"), q(91859, "A Curious Pair"), q(91860, "A Grim Fate"), q(91861, "Into Fenris Keep"),
                q(91862, "Lumina Windsinger"), q(96204, "The Windshaper's Wrath"), q(95034, "The Debt"), q(95036, "A Moon-Kissed Blade"),
                q(95111, "An Underrated Talent"), q(95125, "Ott's Masterwork"), q(95126, "The Moonsilver Blade") },
      start = { npc = "Danitha Morr", zone = "Tirisfal Glades" }, zones = { "Silverpine Forest", "Hillsbrad Foothills" },
      confidence = "forever-guide" },
    -- level 35+: Aeonas (Scarlet Monastery), then its two follow-ups
    { key = "pal35aeonas", level = 35, faction = "Alliance",
      title = "A Brother In Need (Aeonas)", reward = "see the quests on Wowhead",
      steps = { q(79945, "Orders from the Grand Crusader"), q(79946, "A Brother In Need"), q(79963, "By The Light's Grace"),
                q(79970, "Aeonas the Vindicated") },
      start = { npc = "Katherine the Pure", zone = "Stormwind City" }, zones = { "Scarlet Monastery" },
      area = { min = 35, name = "Scarlet Monastery" }, confidence = "forever-guide" },
    { key = "pal45news", level = 45, faction = "Alliance", after = "pal35aeonas",
      title = "Elrick, Paladin of the Silver Hand", reward = "see the quests on Wowhead",
      steps = { q(81762, "Some Good News"), q(81764, "The Mysterious Merchant"), q(81765, "Elrick, Paladin of the Silver Hand") },
      start = { npc = "Aeonas the Vindicated", zone = "Stormwind City" }, zones = { "Dustwallow Marsh" }, confidence = "forever-guide" },
    { key = "pal45ritual", level = 45, faction = "Alliance", after = "pal35aeonas",
      title = "The Ritual (Aeonas)", reward = "see the quests on Wowhead",
      steps = { q(81885, "The Ritual"), q(82135, "The Price of Hope") },
      start = { npc = "Aeonas the Vindicated", zone = "Felwood" }, confidence = "forever-guide" },
    -- level 40: mounts
    { key = "pal40", level = 40, faction = "Alliance",
      title = "The Tome of Nobility", reward = "see the quest on Wowhead",
      steps = { q(1661, "The Tome of Nobility") }, start = { npc = "Duthorian Rall", zone = "Stormwind City" },
      confidence = "forever-guide" },
    { key = "pal40h", level = 40, faction = "Horde",
      title = "A Paladin's Steed", reward = "see the quests on Wowhead",
      steps = { q(97022, "Report to Danitha"), q(94971, "A Paladin's Steed") },
      start = { note = "Garen Largo (Undercity) or Alodan the Hopeful (Thunder Bluff)" }, confidence = "forever-guide" },
    -- level 60: Charger
    { key = "pal60", level = 60, faction = "Alliance", races = { "Human" },
      title = "Summon Charger (epic mount)", reward = "Summon Charger", spell = 23214,
      steps = { q(7638, "Lord Grayson Shadowbreaker"), q(7637, "Emphasis on Sacrifice"), q(7639, "To Show Due Judgment"),
                q(7640, "Exorcising Terrordale"), q(7641, "The Work of Grimand Elmore"), q(7642, "Collection of Goods"),
                { id = 7645, name = "Manna-Enriched Horse Feed", note = "Accept Ancient Equine Spirit from Lord Grayson first: the horse feed quest opens when you do." },
                q(7643, "Ancient Equine Spirit"), q(7644, "Blessed Arcanite Barding"), q(7646, "The Divination Scryer"),
                q(7647, "Judgment and Redemption") },
      start = { npc = "Duthorian Rall", zone = "Stormwind City" },
      zones = { "Ironforge", "Eastern Plaguelands", "Hillsbrad Foothills", "Dire Maul", "Scholomance" },
      note = "If the charger's soul is lost: Again Into the Great Ossuary (Lord Grayson) lets you try again.",
      confidence = "forever-guide" },
    { key = "pal60d", level = 60, faction = "Alliance", races = { "Dwarf" },
      title = "Summon Charger (epic mount)", reward = "Summon Charger", spell = 23214,
      steps = { q(7670, "Lord Grayson Shadowbreaker"), q(7637, "Emphasis on Sacrifice"), q(7639, "To Show Due Judgment"),
                q(7640, "Exorcising Terrordale"), q(7641, "The Work of Grimand Elmore"), q(7642, "Collection of Goods"),
                { id = 7645, name = "Manna-Enriched Horse Feed", note = "Accept Ancient Equine Spirit from Lord Grayson first: the horse feed quest opens when you do." },
                q(7643, "Ancient Equine Spirit"), q(7644, "Blessed Arcanite Barding"), q(7646, "The Divination Scryer"),
                q(7647, "Judgment and Redemption") },
      start = { npc = "Brandur Ironhammer", zone = "Ironforge" },
      zones = { "Stormwind City", "Eastern Plaguelands", "Hillsbrad Foothills", "Dire Maul", "Scholomance" },
      note = "If the charger's soul is lost: Again Into the Great Ossuary (Lord Grayson) lets you try again.",
      confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[1641] = { races = { 1 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Divinity (level 12)
Q[1642] = { races = { 1 }, requires = { { 1641, "The Tome of Divinity" } }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Divinity (level 12)
Q[1643] = { races = { 1 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Stephanie Turner", zone = "Stormwind City", x = 63.6, y = 72.2 } } -- The Tome of Divinity (level 12)
Q[1644] = { races = { 1 }, start = { npc = "Stephanie Turner", zone = "Stormwind City", x = 63.6, y = 72.2 }, finish = { npc = "Stephanie Turner", zone = "Stormwind City", x = 63.6, y = 72.2 }, obj = { { item = 2589, name = "Linen Cloth", qty = 10 } } } -- The Tome of Divinity (level 13)
Q[1645] = { races = { 3 }, start = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 }, finish = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 } } -- The Tome of Divinity (level 12)
Q[1646] = { races = { 3 }, requires = { { 1645, "The Tome of Divinity" } }, finish = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 } } -- The Tome of Divinity (level 12)
Q[1647] = { races = { 3 }, start = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 }, finish = { npc = "John Turner", zone = "Ironforge", x = 27.8, y = 70 } } -- The Tome of Divinity (level 12)
Q[1648] = { races = { 3 }, start = { npc = "John Turner", zone = "Ironforge", x = 27.8, y = 70 }, finish = { npc = "John Turner", zone = "Ironforge", x = 27.8, y = 70 }, obj = { { item = 2589, name = "Linen Cloth", qty = 10 } } } -- The Tome of Divinity (level 13)
-- Wowhead lists no quest giver for 1642, 1646 and 1649
Q[1649] = { finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Valor (level 20)
Q[1650] = { races = { 1, 3 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Daphne Stilwell", zone = "Westfall", x = 42.3, y = 88.5 } } -- The Tome of Valor (level 23)
Q[1651] = { races = { 1, 3 }, requires = { { 1650, "The Tome of Valor" } }, start = { npc = "Daphne Stilwell", zone = "Westfall", x = 42.3, y = 88.5 }, finish = { npc = "Daphne Stilwell", zone = "Westfall", x = 42.3, y = 88.5 } } -- The Tome of Valor (level 25)
Q[1652] = { races = { 1, 3 }, start = { npc = "Daphne Stilwell", zone = "Westfall", x = 42.3, y = 88.5 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Valor (level 25)
Q[1653] = { races = { 1, 3 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Jordan Stilwell", zone = "Dun Morogh", x = 52.4, y = 36.8 } } -- The Test of Righteousness (level 21)
Q[1654] = { races = { 1, 3 }, start = { npc = "Jordan Stilwell", zone = "Dun Morogh", x = 52.4, y = 36.8 }, finish = { npc = "Jordan Stilwell", zone = "Dun Morogh", x = 52.4, y = 36.8 }, obj = { { item = 6994, name = "Whitestone Oak Lumber", qty = 1, from = "Goblin Woodcarver (18-19)", zone = "The Deadmines", areaMin = 18 }, { item = 6993, name = "Jordan's Refined Ore Shipment", qty = 1 }, { item = 6895, name = "Jordan's Smithing Hammer", qty = 1 }, { item = 7083, name = "Purified Kor Gem", qty = 1 } } } -- The Test of Righteousness (level 22)
Q[1655] = { races = { 1, 3 }, requires = { { 1654, "The Test of Righteousness" } }, start = { npc = "Bailor Stonehand", zone = "Loch Modan", x = 36, y = 45 }, finish = { npc = "Bailor Stonehand", zone = "Loch Modan", x = 36, y = 45 }, obj = { { item = 6992, name = "Jordan's Ore Shipment", qty = 1 } } } -- Bailor's Ore Shipment (level 22)
Q[1661] = { races = { 1, 3 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Nobility (level 40)
Q[1778] = { races = { 3 }, start = { npc = "John Turner", zone = "Ironforge", x = 27.8, y = 70 }, finish = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 } } -- The Tome of Divinity (level 13)
Q[1779] = { races = { 3 }, start = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 }, finish = { npc = "Muiredon Battleforge", zone = "Ironforge", x = 23.6, y = 8.8 } } -- The Tome of Divinity (level 13)
Q[1780] = { races = { 1 }, start = { npc = "Stephanie Turner", zone = "Stormwind City", x = 63.6, y = 72.2 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Divinity (level 13)
Q[1781] = { races = { 1 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Gazin Tenorm", zone = "Stormwind City", x = 49.6, y = 45 } } -- The Tome of Divinity (level 13)
Q[1783] = { races = { 3 }, start = { npc = "Muiredon Battleforge", zone = "Ironforge", x = 23.6, y = 8.8 }, finish = { npc = "Narm Faulk", zone = "Dun Morogh", x = 78.2, y = 58 } } -- The Tome of Divinity (level 13)
Q[1784] = { races = { 3 }, start = { npc = "Narm Faulk", zone = "Dun Morogh", x = 78.2, y = 58 }, finish = { npc = "Muiredon Battleforge", zone = "Ironforge", x = 23.6, y = 8.8 }, obj = { { item = 6847, name = "Dark Iron Script", qty = 1, from = "Dark Iron Spy", zone = "Dun Morogh", x = 77.8, y = 62 } } } -- The Tome of Divinity (level 13)
Q[1785] = { races = { 3 }, start = { npc = "Muiredon Battleforge", zone = "Ironforge", x = 23.6, y = 8.8 }, finish = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 } } -- The Tome of Divinity (level 13)
Q[1786] = { races = { 1 }, start = { npc = "Gazin Tenorm", zone = "Stormwind City", x = 49.6, y = 45 }, finish = { npc = "Henze Faulk", zone = "Elwynn Forest", x = 72.6, y = 51.4 } } -- The Tome of Divinity (level 13)
Q[1787] = { races = { 1 }, start = { npc = "Henze Faulk", zone = "Elwynn Forest", x = 72.6, y = 51.4 }, finish = { npc = "Gazin Tenorm", zone = "Stormwind City", x = 49.6, y = 45 }, obj = { { item = 6846, name = "Defias Script", qty = 1, from = "Defias Bodyguard / Defias Rogue Wizard", zone = "Elwynn Forest", x = 74.1, y = 50.9 } } } -- The Tome of Divinity (level 13)
Q[1788] = { races = { 1 }, start = { npc = "Gazin Tenorm", zone = "Stormwind City", x = 49.6, y = 45 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Divinity (level 13)
Q[1789] = { races = { 3 }, requiresActive = { { 1783, "The Tome of Divinity" } }, start = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 }, finish = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 } } -- The Symbol of Life (level 12)
Q[1790] = { races = { 1 }, requiresActive = { { 1786, "The Tome of Divinity" } }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Symbol of Life (level 12)
Q[1793] = { start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Valor (level 20)
Q[1794] = { start = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 }, finish = { npc = "Tiza Battleforge", zone = "Ironforge", x = 27.4, y = 12 } } -- The Tome of Valor (level 20)
Q[1806] = { races = { 1, 3 }, start = { npc = "Jordan Stilwell", zone = "Dun Morogh", x = 52.4, y = 36.8 }, finish = { npc = "Jordan Stilwell", zone = "Dun Morogh", x = 52.4, y = 36.8 } } -- The Test of Righteousness (level 22)
-- Emphasis on Sacrifice: Wowhead "Requires Any" lists 7638; the Dwarf start 7670 "Unlocks" it too
Q[7637] = { races = { 1, 3 }, requiresOneOf = { { 7638, "Lord Grayson Shadowbreaker" }, { 7670, "Lord Grayson Shadowbreaker" } }, start = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, finish = { npc = "High Priest Rohan", zone = "Ironforge", x = 25, y = 8.4 } } -- Emphasis on Sacrifice (level 60)
Q[7638] = { races = { 1, 3 }, start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 } } -- Lord Grayson Shadowbreaker (level 60)
Q[7639] = { races = { 1, 3 }, start = { npc = "High Priest Rohan", zone = "Ironforge", x = 25, y = 8.4 }, finish = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, obj = { { item = 18819, name = "Rohan's Exorcism Censer", qty = 1 } } } -- To Show Due Judgment (level 60)
Q[7640] = { races = { 1, 3 }, start = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, finish = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, obj = { { kill = 14564, name = "Terrordale Spirit", qty = 25, zone = "Eastern Plaguelands", x = 21.6, y = 34.6 }, { item = 18752, name = "Exorcism Censer", qty = 1 } } } -- Exorcising Terrordale (level 60)
Q[7641] = { races = { 1, 3 }, requires = { { 7640, "Exorcising Terrordale" } }, start = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, finish = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 } } -- The Work of Grimand Elmore (level 60)
Q[7642] = { races = { 1, 3 }, start = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 }, finish = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 }, obj = { { item = 13180, name = "Stratholme Holy Water", qty = 5 }, { item = 8836, name = "Arthas' Tears", qty = 10 }, { item = 14047, name = "Runecloth", qty = 40 }, { item = 12360, name = "Arcanite Bar", qty = 6 } } } -- Collection of Goods (level 60)
Q[7643] = { races = { 1, 3 }, requires = { { 7642, "Collection of Goods" } }, start = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, finish = { npc = "Ancient Equine Spirit", zone = "Dire Maul" }, obj = { { item = 18753, name = "Arcanite Barding", qty = 1 }, { item = 18775, name = "Manna-Enriched Horse Feed", qty = 1 } } } -- Ancient Equine Spirit (level 60)
Q[7644] = { races = { 1, 3 }, start = { npc = "Ancient Equine Spirit", zone = "Dire Maul" }, finish = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, obj = { { item = 18792, name = "Blessed Arcanite Barding", qty = 1 } } } -- Blessed Arcanite Barding (level 60)
Q[7645] = { races = { 1, 3 }, requiresActive = { { 7643, "Ancient Equine Spirit" } }, start = { npc = "Merideth Carlson", zone = "Hillsbrad Foothills", x = 52, y = 55.6 }, finish = { npc = "Merideth Carlson", zone = "Hillsbrad Foothills", x = 52, y = 55.6 }, obj = { { item = 13724, name = "Enriched Manna Biscuit", qty = 20 } } } -- Manna-Enriched Horse Feed (level 60)
Q[7646] = { races = { 1, 3 }, start = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, finish = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, obj = { { item = 12800, name = "Azerothian Diamond", qty = 1 }, { item = 18335, name = "Pristine Black Diamond", qty = 1 } } } -- The Divination Scryer (level 60)
Q[7647] = { races = { 1, 3 }, start = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 }, finish = { npc = "Darkreaver's Fallen Charger", zone = "Scholomance" }, obj = { { item = 18799, name = "Charger's Redeemed Soul", qty = 1 }, { item = 18792, name = "Blessed Arcanite Barding", qty = 1 }, { item = 18749, name = "Charger's Lost Soul", qty = 1, from = "Death Knight Darkreaver", zone = "Scholomance" }, { item = 18746, name = "Divination Scryer", qty = 1 } } } -- Judgment and Redemption (level 60)
Q[7670] = { races = { 1, 3 }, start = { npc = "Brandur Ironhammer", zone = "Ironforge", x = 23.4, y = 6.2 }, finish = { npc = "Lord Grayson Shadowbreaker", zone = "Stormwind City", x = 48.6, y = 50 } } -- Lord Grayson Shadowbreaker (level 60)
Q[79945] = { finish = { npc = "Katherine the Pure", zone = "Stormwind City", x = 48.6, y = 49.2 }, obj = { { kill = 5492, name = "Report back to Katherine the Pure", qty = 1, from = "Katherine the Pure", zone = "Stormwind City", x = 48.6, y = 49.2 }, { item = 216610, name = "Orders from the Grand Crusader", qty = 1 } } } -- Orders from the Grand Crusader (level 40)
Q[79946] = { races = { 1, 3 }, start = { npc = "Katherine the Pure", zone = "Stormwind City", x = 48.6, y = 49.2 }, finish = { npc = "Aeonas", zone = "Scarlet Monastery" }, obj = { { kill = 218238, name = "Learn more about Aeonas from Katherine", qty = 1 }, { kill = 217996, name = "Find Aeonas in the Scarlet Monastery", qty = 1, from = "Aeonas", zone = "Scarlet Monastery" } } } -- A Brother In Need (level 40)
Q[79963] = { races = { 1, 3 }, start = { npc = "Aeonas", zone = "Scarlet Monastery" }, finish = { npc = "Aeonas", zone = "Scarlet Monastery" }, obj = { { kill = 218007, name = "Heal Aeonas", qty = 1 } } } -- By The Light's Grace (level 40)
Q[79970] = { races = { 1, 3 }, start = { npc = "Aeonas", zone = "Scarlet Monastery" }, finish = { npc = "Aeonas the Vindicated", zone = "Stormwind City", x = 48.6, y = 49.2 }, obj = { { kill = 218160, name = "Meet Aeonas at the Cathedral of Light in Stormwind", qty = 1, from = "Aeonas the Vindicated", zone = "Stormwind City", x = 48.6, y = 49.2 } } } -- Aeonas the Vindicated (level 40)
Q[81762] = { races = { 1, 3 }, start = { npc = "Aeonas the Vindicated", zone = "Stormwind City", x = 48.6, y = 49.2 }, finish = { npc = "Katherine the Pure", zone = "Stormwind City", x = 48.6, y = 49.2 } } -- Some Good News (level 50)
Q[81764] = { races = { 1, 3 }, start = { npc = "Katherine the Pure", zone = "Stormwind City", x = 48.6, y = 49.2 }, finish = { npc = "Elrick", zone = "Dustwallow Marsh", x = 66.4, y = 45.4 }, obj = { { kill = 221575, name = "Travel to Theramore and find the mysterious merchant.", qty = 1, from = "Elrick", zone = "Dustwallow Marsh", x = 66.4, y = 45.4 } } } -- The Mysterious Merchant (level 50)
Q[81765] = { races = { 1, 3 }, start = { npc = "Elrick", zone = "Dustwallow Marsh", x = 66.4, y = 45.4 }, finish = { npc = "Innkeeper Janene", zone = "Dustwallow Marsh", x = 66.6, y = 45.2 }, obj = { { kill = 221575, name = "Speak with Elrick and learn more", qty = 1, from = "Elrick", zone = "Dustwallow Marsh", x = 66.4, y = 45.4 } } } -- Elrick, Paladin of the Silver Hand (level 50)
Q[81885] = { races = { 1, 3 }, start = { npc = "Aeonas the Vindicated", zone = "Felwood", x = 45, y = 52 }, finish = { npc = "Aeonas the Vindicated", zone = "Felwood", x = 45, y = 52 }, obj = { { kill = 221838, name = "Complete the Ritual", qty = 1 } } } -- The Ritual (level 53)
Q[82135] = { races = { 1, 3 }, start = { npc = "Aeonas the Vindicated", zone = "Felwood", x = 45, y = 52 }, finish = { npc = "Katherine the Pure", zone = "Stormwind City", x = 48.6, y = 49.2 }, obj = { { item = 221519, name = "Mannoroc Orb", qty = 1 } } } -- The Price of Hope (level 53)
Q[91858] = { races = { 5 }, start = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 } } -- Diplomatic Incident (level 22)
Q[91859] = { races = { 5 }, start = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, finish = { npc = "Deathguard Baldren", zone = "Silverpine Forest", x = 45.6, y = 41.8 } } -- A Curious Pair (level 22)
Q[91860] = { races = { 5 }, start = { npc = "Deathguard Baldren", zone = "Silverpine Forest", x = 45.6, y = 41.8 }, finish = { npc = "Charred Remains", zone = "Silverpine Forest", x = 65, y = 34.2 } } -- A Grim Fate (level 22)
Q[91861] = { races = { 5 }, start = { npc = "Charred Remains", zone = "Silverpine Forest", x = 65, y = 34.2 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 } } -- Into Fenris Keep (level 22)
Q[91862] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 }, obj = { { item = 267412, name = "Fenris Isle Key", qty = 1, from = "Rot Hide Bruiser / Rot Hide Savage / Raging Rot Hide", zone = "Silverpine Forest", x = 67, y = 24.4 } } } -- Lumina Windsinger (level 22)
Q[94427] = { races = { 5 }, start = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Tanis Alderwood", zone = "Undercity", x = 65.6, y = 37.8 } } -- A Lesson in Divinity (level 12)
Q[94434] = { races = { 5 }, start = { npc = "Tanis Alderwood", zone = "Undercity", x = 65.6, y = 37.8 }, finish = { npc = "Tanis Alderwood", zone = "Undercity", x = 65.6, y = 37.8 }, obj = { { item = 2589, name = "Linen Cloth", qty = 10, from = "Scarlet Missionary / Scarlet Zealot" } } } -- A Lesson in Divinity (level 12)
Q[94435] = { races = { 5 }, start = { npc = "Tanis Alderwood", zone = "Undercity", x = 65.6, y = 37.8 }, finish = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 } } -- A Lesson in Divinity (level 12)
Q[94436] = { races = { 5 }, start = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Deathguard Billmuth", zone = "Tirisfal Glades", x = 22, y = 44.6 } } -- A Lesson in Divinity (level 12)
Q[94438] = { races = { 5 }, start = { npc = "Deathguard Billmuth", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Deathguard Falgan", zone = "Tirisfal Glades", x = 86.6, y = 47.6 } } -- A Lesson in Divinity (level 12)
Q[94440] = { races = { 5 }, start = { npc = "Deathguard Falgan", zone = "Tirisfal Glades", x = 86.6, y = 47.6 }, finish = { npc = "Deathguard Billmuth", zone = "Tirisfal Glades", x = 22, y = 44.6 }, obj = { { item = 264693, name = "Scarlet Crusade Attack Plans", qty = 1, from = "Scarlet Zealot / Scarlet Friar", zone = "Tirisfal Glades", x = 51.6, y = 67.6 } } } -- A Lesson in Divinity (level 12)
Q[94441] = { races = { 5 }, start = { npc = "Deathguard Billmuth", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 } } -- A Lesson in Divinity (level 12)
Q[94971] = { races = { 5, 6 }, start = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 } } -- A Paladin's Steed (level 40)
Q[95034] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 }, obj = { { kill = 259620, name = "Speak with Lumina Windsinger", qty = 1, from = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 } } } -- The Debt (level 24)
Q[95036] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 }, finish = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, obj = { { item = 267454, name = "Trevan's Weapon Notes", qty = 1 }, { item = 6994, name = "Whitestone Oak Lumber", qty = 1, from = "Goblin Woodcarver (18-19)", zone = "The Deadmines", areaMin = 18 }, { item = 267361, name = "Enchanted Silver Ingot", qty = 1 }, { item = 272448, name = "Purified Kor Gem", qty = 1 } } } -- A Moon-Kissed Blade (level 25)
Q[95111] = { races = { 5 }, start = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, finish = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, obj = { { item = 268192, name = "Bundle of Blacksmithing Materials", qty = 1 } } } -- An Underrated Talent (level 25)
Q[95125] = { races = { 5 }, start = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, finish = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, obj = { { kill = 259966, name = "Watch Ott craft the blade", qty = 1 } } } -- Ott's Masterwork (level 25)
Q[95126] = { races = { 5 }, start = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, finish = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, obj = { { item = 268359, name = "Ott's Masterwork", qty = 1 } } } -- The Moonsilver Blade (level 25)
Q[96204] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 } } -- The Windshaper's Wrath (level 22)
Q[97022] = { races = { 5, 6 }, starts = { { npc = "Garen Largo", zone = "Undercity", x = 47.6, y = 14.8, races = { 5 } }, { npc = "Alodan the Hopeful", zone = "Thunder Bluff", x = 25.4, y = 14.6 } }, finish = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 } } -- Report to Danitha (level 40)
