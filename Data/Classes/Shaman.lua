-- Journal Assistant - Shaman class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q = D.QuestStep

D.classQuests.SHAMAN = {
    { key = "sha4earth", level = 4, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Earth (Earth Totem)", reward = "Stoneskin Totem, Earth Totem", spell = 8071,
      steps = { q(96243, "Call of Earth"), q(94373, "Call of Earth"), q(94374, "Call of Earth"), q(94375, "Call of Earth") },
      start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", note = "Anvilmar" }, confidence = "forever-guide" },
    { key = "sha10fire", level = 10, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Fire (Fire Totem)", reward = "Searing Totem, Fire Totem", spell = 3599,
      steps = { q(94449, "Call of Fire"), q(94465, "Call of Fire"), q(94466, "Call of Fire"), q(94467, "Call of Fire"), q(94468, "Call of Fire") },
      start = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", note = "cave above South Gate Outpost" }, confidence = "forever-guide" },
    { key = "sha4sapta", level = 4, faction = "Alliance", races = { "Dwarf" }, optional = true,
      title = "Earth Sapta", reward = "Earth Sapta",
      steps = { q(94472, "Earth Sapta") }, start = { npc = "Teo Hammerstorm", zone = "Dun Morogh" }, confidence = "forever-guide" },
    -- Call of Water: series 94495 > 94505 on wowhead.com/forever (checked 2026-11-21)
    { key = "sha20water", level = 20, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Water (Water Totem)", reward = "Healing Stream Totem, Water Totem", spell = 5394,
      steps = { q(94495, "Call of Water"), q(94497, "Call of Water"), q(94499, "Call of Water"), q(94500, "Call of Water"),
                q(94501, "Call of Water"), q(94502, "Call of Water"), q(94503, "Call of Water"), q(94505, "Call of Water") },
      start = { npc = "Norric Lochthane", zone = "Loch Modan", x = 41.8, y = 19.0 },
      zones = { "Wetlands", "Westfall" }, confidence = "forever-guide" },
    { key = "sha30air", level = 30, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Air (Air Totem)", reward = "Air Totem, then a specialization weapon",
      steps = { q(94789, "Call of Air"), q(96264, "Elemental Aid"), q(79358, "Storm, Earth, and Fire"), q(96135, "Heed My Call"), q(96016, "The Tempest's Weapons") },
      start = { npc = "Veyric Thundervein", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, confidence = "forever-guide" },
    -- Horde (quest givers per race: Durotar / Orgrimmar for Orcs and Trolls,
    -- Mulgore / Thunder Bluff for Tauren; races from each quest's Wowhead page)
    { key = "sha4earthh", level = 4, faction = "Horde", races = { "Orc" },
      title = "Call of Earth (Earth Totem)", reward = "Stoneskin Totem, Earth Totem", spell = 8071,
      steps = { q(1516, "Call of Earth"), q(1517, "Call of Earth"), q(1518, "Call of Earth") },
      start = { npc = "Canaga Earthcaller", zone = "Durotar", note = "Valley of Trials" }, confidence = "forever-guide" },
    { key = "sha4eartht", level = 4, faction = "Horde", races = { "Tauren" },
      title = "Call of Earth (Earth Totem)", reward = "Stoneskin Totem, Earth Totem", spell = 8071,
      steps = { q(1519, "Call of Earth"), q(1520, "Call of Earth"), q(1521, "Call of Earth") },
      start = { npc = "Seer Ravenfeather", zone = "Mulgore", note = "Camp Narache" }, confidence = "forever-guide" },
    { key = "sha4saptah", level = 4, faction = "Horde", races = { "Orc", "Troll" }, optional = true,
      title = "Earth Sapta", reward = "Earth Sapta",
      steps = { q(1463, "Earth Sapta") }, start = { npc = "Canaga Earthcaller", zone = "Durotar" }, confidence = "forever-guide" },
    { key = "sha4saptat", level = 4, faction = "Horde", races = { "Tauren" }, optional = true,
      title = "Earth Sapta", reward = "Earth Sapta",
      steps = { q(1462, "Earth Sapta") }, start = { npc = "Seer Ravenfeather", zone = "Mulgore" }, confidence = "forever-guide" },
    { key = "sha10fireh", level = 10, faction = "Horde", races = { "Orc" },
      title = "Call of Fire (Fire Totem)", reward = "Searing Totem, Fire Totem", spell = 3599,
      steps = { q(1522, "Call of Fire"), q(1524, "Call of Fire"), q(1525, "Call of Fire"),
                { id = 1464, name = "Fire Sapta", note = "Accept the next Call of Fire from Telf Joolam first: Fire Sapta opens when you do." },
                q(1526, "Call of Fire"), q(1527, "Call of Fire") },
      start = { npc = "Searn Firewarder", zone = "Orgrimmar" }, zones = { "The Barrens", "Durotar" }, confidence = "forever-guide" },
    { key = "sha10firet", level = 10, faction = "Horde", races = { "Tauren" },
      title = "Call of Fire (Fire Totem)", reward = "Searing Totem, Fire Totem", spell = 3599,
      steps = { q(1523, "Call of Fire"), q(1524, "Call of Fire"), q(1525, "Call of Fire"),
                { id = 1464, name = "Fire Sapta", note = "Accept the next Call of Fire from Telf Joolam first: Fire Sapta opens when you do." },
                q(1526, "Call of Fire"), q(1527, "Call of Fire") },
      start = { npc = "Xanis Flameweaver", zone = "Thunder Bluff" }, zones = { "The Barrens", "Durotar" }, confidence = "forever-guide" },
    { key = "sha10firesky", level = 10, races = { "Skyborne" },
      title = "Call of Fire (Fire Totem)", reward = "Fire Totem",
      steps = { q(97245, "Call of Fire"), q(97257, "Call of Fire") },
      start = { npc = "Olariaan Swiftburn", zone = "Zephras Isle" },
      note = "Wowhead lists no race for these two quests; both start on Zephras Isle.", confidence = "forever-guide" },
    { key = "sha20waterh", level = 20, faction = "Horde", races = { "Orc", "Troll" },
      title = "Call of Water (Water Totem)", reward = "Healing Stream Totem, Water Totem", spell = 5394,
      steps = { q(1528, "Call of Water"), q(1530, "Call of Water"), q(1535, "Call of Water"), q(1536, "Call of Water"),
                q(1534, "Call of Water"), q(220, "Call of Water"), q(63, "Call of Water"),
                { id = 1103, name = "Call of Water", note = "Accept the next Call of Water at the Brazier of Everfount first: Tiev Mordune's quest opens when you do." },
                q(100, "Call of Water"), q(96, "Call of Water") },
      start = { npc = "Searn Firewarder", zone = "Orgrimmar" },
      zones = { "The Barrens", "Silverpine Forest", "Westfall" }, confidence = "forever-guide" },
    { key = "sha20watert", level = 20, faction = "Horde", races = { "Tauren" },
      title = "Call of Water (Water Totem)", reward = "Healing Stream Totem, Water Totem", spell = 5394,
      steps = { q(1529, "Call of Water"), q(1530, "Call of Water"), q(1535, "Call of Water"), q(1536, "Call of Water"),
                q(1534, "Call of Water"), q(220, "Call of Water"), q(63, "Call of Water"),
                { id = 1103, name = "Call of Water", note = "Accept the next Call of Water at the Brazier of Everfount first: Tiev Mordune's quest opens when you do." },
                q(100, "Call of Water"), q(96, "Call of Water") },
      start = { npc = "Xanis Flameweaver", zone = "Thunder Bluff" },
      zones = { "The Barrens", "Silverpine Forest", "Westfall" }, confidence = "forever-guide" },
    { key = "sha30airh", level = 30, faction = "Horde", races = { "Orc", "Troll" },
      title = "Call of Air (Air Totem)", reward = "Air Totem",
      steps = { q(1531, "Call of Air") }, start = { npc = "Searn Firewarder", zone = "Orgrimmar" },
      zones = { "Thousand Needles" }, confidence = "forever-guide" },
    { key = "sha30airt", level = 30, faction = "Horde", races = { "Tauren" },
      title = "Call of Air (Air Totem)", reward = "Air Totem",
      steps = { q(1532, "Call of Air") }, start = { npc = "Xanis Flameweaver", zone = "Thunder Bluff" },
      zones = { "Thousand Needles" }, confidence = "forever-guide" },
    -- race 96 on Wowhead: the chain only shows for that race (quest race check)
    { key = "sha30air96", level = 30, faction = "Horde",
      title = "Call of Air (Air Totem)", reward = "Air Totem",
      steps = { q(96136, "Call of Air") }, start = { npc = "Alaana Stormwalker", zone = "Mulgore" },
      zones = { "Thousand Needles" }, confidence = "forever-guide" },
    { key = "sha30aidh", level = 30, faction = "Horde",
      title = "Elemental Aid", reward = "a specialization weapon",
      steps = { q(79360, "Elemental Aid"), q(79364, "Eyes on the Sky"), q(79361, "Storm, Earth, and Fire"),
                q(79366, "Heed My Call"), q(79442, "The Tempest's Weapons") },
      start = { npc = "Rau Cliffrunner", zone = "Thousand Needles" },
      zones = { "Razorfen Kraul", "Thousand Needles", "Alterac Mountains" }, confidence = "forever-guide" },
    { key = "sha50master", level = 50, faction = "Horde", optional = true,
      title = "Elemental Mastery", reward = "see the quests on Wowhead",
      steps = { q(8410, "Elemental Mastery"), q(8411, "Mastering the Elements"), q(8412, "Spirit Totem"), q(8413, "Da Voodoo") },
      zones = { "Alterac Mountains", "Tirisfal Glades" }, confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[63] = { requires = { { 220, "Call of Water" } }, start = { npc = "Islen Waterseer", zone = "The Barrens", x = 65.8, y = 43.8 }, finish = { npc = "Brazier of Everfount", zone = "Silverpine Forest", x = 38.2, y = 44.5 }, obj = { { item = 7812, name = "Corrupt Manifestation's Bracers", qty = 1, from = "Corrupt Minor Manifestation of Water", zone = "Westfall", x = 45.8, y = 60 }, { item = 7811, name = "Remaining Drops of Purest Water", qty = 1 } } } -- Call of Water (level 23)
Q[96] = { start = { npc = "Minor Manifestation of Water", zone = "Westfall", x = 46.4, y = 59.2 }, finish = { npc = "Islen Waterseer", zone = "The Barrens", x = 65.8, y = 43.8 }, obj = { { item = 7813, name = "Shard of Water", qty = 1 } } } -- Call of Water (level 23)
Q[100] = { start = { npc = "Brazier of Everfount", zone = "Silverpine Forest", x = 38.2, y = 44.5 }, finish = { npc = "Minor Manifestation of Water", zone = "Westfall", x = 46.4, y = 59.2 } } -- Call of Water (level 23)
Q[220] = { start = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, finish = { npc = "Islen Waterseer", zone = "The Barrens", x = 65.8, y = 43.8 }, obj = { { item = 7810, name = "Vial of Purest Water", qty = 1 } } } -- Call of Water (level 23)
Q[1103] = { requiresActive = { { 100, "Call of Water" } }, start = { npc = "Tiev Mordune", zone = "Silverpine Forest", x = 37.4, y = 44 }, finish = { npc = "Tiev Mordune", zone = "Silverpine Forest", x = 37.4, y = 44 }, obj = { { item = 6637, name = "Water Sapta", qty = 1 } } } -- Call of Water (level 23)
Q[1462] = { start = { npc = "Seer Ravenfeather", zone = "Mulgore", x = 44.3, y = 76.7 }, finish = { npc = "Seer Ravenfeather", zone = "Mulgore", x = 44.3, y = 76.7 } } -- Earth Sapta (level 4)
Q[1463] = { start = { npc = "Canaga Earthcaller", zone = "Durotar", x = 42.4, y = 69 }, finish = { npc = "Canaga Earthcaller", zone = "Durotar", x = 42.4, y = 69 } } -- Earth Sapta (level 4)
Q[1464] = { requiresActive = { { 1526, "Call of Fire" } }, start = { npc = "Telf Joolam", zone = "Durotar", x = 38.6, y = 58.8 }, finish = { npc = "Telf Joolam", zone = "Durotar", x = 38.6, y = 58.8 } } -- Fire Sapta (level 13)
Q[1516] = { races = { 2, 6 }, start = { npc = "Canaga Earthcaller", zone = "Durotar", x = 42.4, y = 69 }, finish = { npc = "Canaga Earthcaller", zone = "Durotar", x = 42.4, y = 69 }, obj = { { item = 6640, name = "Felstalker Hoof", qty = 2, from = "Felstalker", zone = "Durotar", x = 45.2, y = 55 } } } -- Call of Earth (level 4)
-- the Minor Manifestation of Earth stands in Durotar, Mulgore and Dun Morogh (quest=94375 map)
Q[1517] = { races = { 2, 6 }, start = { npc = "Canaga Earthcaller", zone = "Durotar", x = 42.4, y = 69 }, finish = { npc = "Minor Manifestation of Earth", zone = "Durotar", x = 44, y = 76 } } -- Call of Earth (level 4)
Q[1518] = { races = { 2, 6 }, start = { npc = "Minor Manifestation of Earth", zone = "Durotar", x = 44, y = 76 }, finish = { npc = "Canaga Earthcaller", zone = "Durotar", x = 42.4, y = 69 }, obj = { { item = 6656, name = "Rough Quartz", qty = 1 } } } -- Call of Earth (level 4)
Q[1519] = { races = { 2, 6 }, start = { npc = "Seer Ravenfeather", zone = "Mulgore", x = 44.3, y = 76.7 }, finish = { npc = "Seer Ravenfeather", zone = "Mulgore", x = 44.3, y = 76.7 }, obj = { { item = 6634, name = "Ritual Salve", qty = 2, from = "Bristleback Shaman", zone = "Mulgore", x = 64.6, y = 77.8 } } } -- Call of Earth (level 4)
Q[1520] = { races = { 2, 6 }, start = { npc = "Seer Ravenfeather", zone = "Mulgore", x = 44.3, y = 76.7 }, finish = { npc = "Minor Manifestation of Earth", zone = "Mulgore", x = 53.8, y = 80.4 } } -- Call of Earth (level 4)
Q[1521] = { races = { 2, 6 }, start = { npc = "Minor Manifestation of Earth", zone = "Mulgore", x = 53.8, y = 80.4 }, finish = { npc = "Seer Ravenfeather", zone = "Mulgore", x = 44.3, y = 76.7 }, obj = { { item = 6656, name = "Rough Quartz", qty = 1 } } } -- Call of Earth (level 4)
Q[1522] = { races = { 2, 6 }, start = { npc = "Searn Firewarder", zone = "Orgrimmar", x = 37.8, y = 37.4 }, finish = { npc = "Kranal Fiss", zone = "The Barrens", x = 55.8, y = 20 } } -- Call of Fire (level 10)
Q[1523] = { races = { 2, 6 }, start = { npc = "Xanis Flameweaver", zone = "Thunder Bluff", x = 25.2, y = 21 }, finish = { npc = "Kranal Fiss", zone = "The Barrens", x = 55.8, y = 20 } } -- Call of Fire (level 10)
-- Wowhead "Requires Any" lists 1522; 1523 (Thunder Bluff) leads to Kranal Fiss too
Q[1524] = { races = { 2, 6 }, requiresOneOf = { { 1522, "Call of Fire" }, { 1523, "Call of Fire" } }, start = { npc = "Kranal Fiss", zone = "The Barrens", x = 55.8, y = 20 }, finish = { npc = "Telf Joolam", zone = "Durotar", x = 38.6, y = 58.8 }, obj = { { item = 6653, name = "Torch of the Dormant Flame", qty = 1 } } } -- Call of Fire (level 11)
Q[1525] = { races = { 2, 6 }, start = { npc = "Telf Joolam", zone = "Durotar", x = 38.6, y = 58.8 }, finish = { npc = "Telf Joolam", zone = "Durotar", x = 38.6, y = 58.8 }, obj = { { item = 5026, name = "Fire Tar", qty = 1, from = "Tunnel Rat Geomancer", zone = "Loch Modan", x = 35, y = 23.4 }, { item = 6652, name = "Reagent Pouch", qty = 1, from = "Burning Blade Cultist / Stonesplinter Seer", zone = "Durotar", x = 52.4, y = 26.8 } } } -- Call of Fire (level 12)
Q[1526] = { races = { 2, 6 }, start = { npc = "Telf Joolam", zone = "Durotar", x = 38.6, y = 58.8 }, finish = { npc = "Brazier of the Dormant Flame", zone = "Durotar", x = 38.9, y = 58.2 }, obj = { { item = 6653, name = "Torch of the Dormant Flame", qty = 1 }, { item = 6655, name = "Glowing Ember", qty = 1, from = "Minor Manifestation of Fire", zone = "Durotar", x = 38.6, y = 58.2 } } } -- Call of Fire (level 13)
Q[1527] = { races = { 2, 6 }, start = { npc = "Brazier of the Dormant Flame", zone = "Durotar", x = 38.9, y = 58.2 }, finish = { npc = "Kranal Fiss", zone = "The Barrens", x = 55.8, y = 20 }, obj = { { item = 6654, name = "Torch of the Eternal Flame", qty = 1 } } } -- Call of Fire (level 13)
Q[1528] = { start = { npc = "Searn Firewarder", zone = "Orgrimmar", x = 37.8, y = 37.4 }, finish = { npc = "Islen Waterseer", zone = "The Barrens", x = 65.8, y = 43.8 } } -- Call of Water (level 20)
Q[1529] = { start = { npc = "Xanis Flameweaver", zone = "Thunder Bluff", x = 25.2, y = 21 }, finish = { npc = "Islen Waterseer", zone = "The Barrens", x = 65.8, y = 43.8 } } -- Call of Water (level 20)
-- Wowhead "Requires Any" lists 1528; 1529 (Thunder Bluff) is in the same series
Q[1530] = { requiresOneOf = { { 1528, "Call of Water" }, { 1529, "Call of Water" } }, start = { npc = "Islen Waterseer", zone = "The Barrens", x = 65.8, y = 43.8 }, finish = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 } } -- Call of Water (level 22)
Q[1531] = { start = { npc = "Searn Firewarder", zone = "Orgrimmar", x = 37.8, y = 37.4 }, finish = { npc = "Prate Cloudseer", zone = "Thousand Needles", x = 53.6, y = 42.8 } } -- Call of Air (level 30)
Q[1532] = { start = { npc = "Xanis Flameweaver", zone = "Thunder Bluff", x = 25.2, y = 21 }, finish = { npc = "Prate Cloudseer", zone = "Thousand Needles", x = 53.6, y = 42.8 } } -- Call of Air (level 30)
Q[1534] = { start = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, finish = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, obj = { { item = 7770, name = "Filled Blue Waterskin", qty = 1 } } } -- Call of Water (level 23)
Q[1535] = { start = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, finish = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, obj = { { item = 7769, name = "Filled Brown Waterskin", qty = 1 } } } -- Call of Water (level 22)
Q[1536] = { start = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, finish = { npc = "Brine", zone = "The Barrens", x = 43.4, y = 77.4 }, obj = { { item = 7771, name = "Filled Red Waterskin", qty = 1 } } } -- Call of Water (level 22)
Q[8410] = { starts = { { npc = "Sagorne Creststrider", zone = "Orgrimmar", x = 38.6, y = 36.2, races = { 2, 8 } }, { npc = "Beram Skychaser", zone = "Thunder Bluff", x = 22.2, y = 19 } }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 7069, name = "Elemental Air", qty = 1 }, { item = 7068, name = "Elemental Fire", qty = 1 }, { item = 7067, name = "Elemental Earth", qty = 1 }, { item = 7070, name = "Elemental Water", qty = 1 } } } -- Elemental Mastery (level 52)
Q[8411] = { start = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 7069, name = "Elemental Air", qty = 1, from = "Cyclonian", zone = "Alterac Mountains", x = 80.6, y = 62 }, { item = 7067, name = "Elemental Earth", qty = 1, from = "Stone Fury / Elemental Slave", zone = "Alterac Mountains", x = 26.4, y = 60.9 }, { item = 7068, name = "Elemental Fire", qty = 1, from = "Ancient Fire Elemental", zone = "Alterac Mountains", x = 60, y = 45.5 }, { item = 7070, name = "Elemental Water", qty = 1 } } } -- Mastering the Elements (level 52)
Q[8412] = { start = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 20610, name = "Bloodshot Spider Eye", qty = 8, from = "Venom Mist Lurker / Tarantula", zone = "Tirisfal Glades", x = 85.8, y = 72.8 }, { item = 20611, name = "Thick Black Claw", qty = 8, from = "Carrion Vulture / Diseased Black Bear", zone = "Tirisfal Glades", x = 85.4, y = 70.2 } } } -- Spirit Totem (level 52)
Q[8413] = { requires = { { 8412, "Spirit Totem" } }, start = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 20606, name = "Amber Voodoo Feather", qty = 2 }, { item = 20607, name = "Blue Voodoo Feather", qty = 2 }, { item = 20608, name = "Green Voodoo Feather", qty = 2 } } } -- Da Voodoo (level 52)
Q[79358] = { races = { 3 }, start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, obj = { { item = 274046, name = "Twisted Water Totem", qty = 5, from = "Mirefin Warrior (37-38) / Mirefin Muckdweller (36-37)", zone = "Dustwallow Marsh", x = 61.6, y = 15.8, mapID = 1445, areaMin = 37 }, { item = 274045, name = "Twisted Earth Totem", qty = 5, from = "Lost One Mudlurker (34-35) / Lost One Fisherman (35-36)", area = 8, x = 46.8, y = 33.2, mapID = 1435, areaMin = 34 }, { item = 274044, name = "Twisted Fire Totem", qty = 5, from = "Dustbelcher Warrior (35-37) / Dustbelcher Mystic (36-37)", area = 3, x = 65.8, y = 23.8, mapID = 1418, areaMin = 35 }, { item = 274047, name = "Twisted Air Totem", qty = 5, from = "Maraudine Scout (37-38) / Maraudine Wrangler (37-38)", area = 405, x = 32.8, y = 60.4, mapID = 1443, areaMin = 37 } } } -- Storm, Earth, and Fire (level 43)
Q[79360] = { start = { npc = "Rau Cliffrunner", zone = "Thousand Needles", x = 46, y = 51.6 }, finish = { npc = "Rau Cliffrunner", zone = "Thousand Needles", x = 46, y = 51.6 }, obj = { { item = 274463, name = "Tattered Note", qty = 1, from = "Charlga Razorflank (33)", zone = "Razorfen Kraul", areaMin = 33 } } } -- Elemental Aid (level 33)
-- same objective items as the Dwarf version (quest 79358): drop sources from there
Q[79361] = { start = { npc = "Prate Cloudseer", zone = "Thousand Needles", x = 53.6, y = 42.8 }, finish = { npc = "Prate Cloudseer", zone = "Thousand Needles", x = 53.6, y = 42.8 }, obj = { { item = 274046, name = "Twisted Water Totem", qty = 5, from = "Mirefin Warrior (37-38) / Mirefin Muckdweller (36-37)", zone = "Dustwallow Marsh", x = 61.6, y = 15.8, mapID = 1445, areaMin = 37 }, { item = 274045, name = "Twisted Earth Totem", qty = 5, from = "Lost One Mudlurker (34-35) / Lost One Fisherman (35-36)", area = 8, x = 46.8, y = 33.2, mapID = 1435, areaMin = 34 }, { item = 274044, name = "Twisted Fire Totem", qty = 5, from = "Dustbelcher Warrior (35-37) / Dustbelcher Mystic (36-37)", area = 3, x = 65.8, y = 23.8, mapID = 1418, areaMin = 35 }, { item = 274047, name = "Twisted Air Totem", qty = 5, from = "Maraudine Scout (37-38) / Maraudine Wrangler (37-38)", area = 405, x = 32.8, y = 60.4, mapID = 1443, areaMin = 37 } } } -- Storm, Earth, and Fire (level 43)
Q[79364] = { start = { npc = "Rau Cliffrunner", zone = "Thousand Needles", x = 46, y = 51.6 }, finish = { npc = "Prate Cloudseer", zone = "Thousand Needles", x = 53.6, y = 42.8 } } -- Eyes on the Sky (level 33)
Q[79366] = { start = { npc = "Rau Cliffrunner", zone = "Thousand Needles", x = 46, y = 51.6 }, finish = { npc = "Rau Cliffrunner", zone = "Thousand Needles", x = 46, y = 51.6 }, obj = { { item = 212792, name = "Eye of the Tempest", qty = 1, from = "Ravaging Tempest (38-40)", zone = "Thousand Needles", x = 36.7, y = 39.5, areaMin = 38 }, { item = 268582, name = "Corrupted Totems", qty = 1 } } } -- Heed My Call (level 40)
Q[79442] = { start = { npc = "Rau Cliffrunner", zone = "Thousand Needles", x = 46, y = 51.6 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 212792, name = "Eye of the Tempest", qty = 1 } } } -- The Tempest's Weapons (level 40)
Q[94373] = { races = { 3 }, start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, obj = { { item = 264356, name = "Iceclaw Bear Pendant", qty = 2, from = "Frostmane Troll Whelp / Frostmane Novice", zone = "Dun Morogh", x = 27.6, y = 80.8 } } } -- Call of Earth (level 4)
Q[94374] = { races = { 3 }, start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, finish = { npc = "Minor Manifestation of Earth", zone = "Dun Morogh", x = 24.8, y = 61.8 } } -- Call of Earth (level 4)
Q[94375] = { races = { 3 }, start = { npc = "Minor Manifestation of Earth", zone = "Dun Morogh", x = 24.8, y = 61.8 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, obj = { { item = 6656, name = "Rough Quartz", qty = 1 } } } -- Call of Earth (level 4)
Q[94449] = { races = { 3 }, start = { npc = "Ingrid Dunwald", zone = "Dun Morogh", x = 47.4, y = 52 }, finish = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", x = 87.6, y = 43.6 } } -- Call of Fire (level 10)
Q[94465] = { races = { 3 }, start = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", x = 87.6, y = 43.6 }, finish = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, obj = { { item = 6653, name = "Torch of the Dormant Flame", qty = 1 } } } -- Call of Fire (level 11)
Q[94466] = { races = { 3 }, start = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, finish = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, obj = { { item = 5026, name = "Fire Tar", qty = 1, from = "Tunnel Rat Geomancer", zone = "Loch Modan", x = 35, y = 23.4 }, { item = 6652, name = "Reagent Pouch", qty = 1, from = "Stonesplinter Seer", zone = "Loch Modan", x = 34, y = 85 } } } -- Call of Fire (level 14)
Q[94467] = { races = { 3 }, start = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, finish = { npc = "Brazier of the Dormant Flame", zone = "Durotar", x = 38.9, y = 58.2 }, obj = { { item = 6653, name = "Torch of the Dormant Flame", qty = 1 }, { item = 6655, name = "Glowing Ember", qty = 1, from = "Minor Manifestation of Fire", zone = "Durotar", x = 38.6, y = 58.2 } } } -- Call of Fire (level 14)
Q[94468] = { races = { 3 }, start = { npc = "Brazier of the Dormant Flame", zone = "Durotar", x = 38.9, y = 58.2 }, finish = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", x = 87.6, y = 43.6 }, obj = { { item = 6654, name = "Torch of the Eternal Flame", qty = 1 } } } -- Call of Fire (level 14)
Q[94472] = { start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 } } -- Earth Sapta (level 4)
Q[94495] = { races = { 3 }, start = { npc = "Norric Lochthane", zone = "Loch Modan", x = 41.8, y = 19 }, finish = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 } } -- Call of Water (level 22)
Q[94497] = { races = { 3 }, start = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, finish = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, obj = { { item = 265734, name = "Full Brown Waterskin", qty = 1 } } } -- Call of Water (level 22)
Q[94499] = { races = { 3 }, start = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, finish = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, obj = { { item = 265748, name = "Full Red Waterskin", qty = 1 } } } -- Call of Water (level 22)
Q[94500] = { races = { 3 }, start = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, finish = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, obj = { { item = 265773, name = "Full Blue Waterskin", qty = 1 } } } -- Call of Water (level 23)
Q[94501] = { races = { 3 }, start = { npc = "Hervdana Saegrund", zone = "Wetlands", x = 65.6, y = 76.4 }, finish = { npc = "Norric Lochthane", zone = "Loch Modan", x = 41.8, y = 19 }, obj = { { item = 7810, name = "Vial of Purest Water", qty = 1 } } } -- Call of Water (level 23)
Q[94502] = { races = { 3 }, start = { npc = "Norric Lochthane", zone = "Loch Modan", x = 41.8, y = 19 }, finish = { npc = "Forgotten Shrine", zone = "Westfall", x = 45.6, y = 59.9 }, obj = { { item = 7812, name = "Corrupt Manifestation's Bracers", qty = 1, from = "Corrupt Minor Manifestation of Water", zone = "Westfall", x = 45.8, y = 60 }, { item = 7811, name = "Remaining Drops of Purest Water", qty = 1 } } } -- Call of Water (level 23)
Q[94503] = { races = { 3 }, start = { npc = "Forgotten Shrine", zone = "Westfall", x = 45.6, y = 59.9 }, finish = { npc = "Minor Manifestation of Water", zone = "Westfall", x = 46.4, y = 59.2 } } -- Call of Water (level 23)
Q[94505] = { races = { 3 }, start = { npc = "Minor Manifestation of Water", zone = "Westfall", x = 46.4, y = 59.2 }, finish = { npc = "Norric Lochthane", zone = "Loch Modan", x = 41.8, y = 19 }, obj = { { item = 7813, name = "Shard of Water", qty = 1 } } } -- Call of Water (level 23)
Q[94789] = { races = { 3 }, start = { npc = "Eldrun Stormbreaker", zone = "Ironforge", x = 47.4, y = 13.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 } } -- Call of Air (level 30)
Q[96016] = { start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 212792, name = "Eye of the Tempest", qty = 1, from = "Ravaging Tempest (38-40)", zone = "Thousand Needles", x = 39.8, y = 39.7, mapID = 1441, areaMin = 38 } } } -- The Tempest's Weapons (level 40)
Q[96135] = { races = { 3 }, start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, obj = { { item = 212792, name = "Eye of the Tempest", qty = 1, from = "Ravaging Tempest (38-40)", zone = "Thousand Needles", x = 36.7, y = 39.5, areaMin = 38 }, { item = 268582, name = "Corrupted Totems", qty = 1 } } } -- Heed My Call (level 40)
Q[96136] = { races = { 96 }, start = { npc = "Alaana Stormwalker", zone = "Mulgore", x = 33.4, y = 22.4 }, finish = { npc = "Prate Cloudseer", zone = "Thousand Needles", x = 53.6, y = 42.8 } } -- Call of Air (level 35)
Q[96243] = { races = { 3, 7, 95 }, start = { npc = "Ingrid Dunwald", zone = "Dun Morogh", x = 47.4, y = 52 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 } } -- Call of Earth (level 4)
Q[96264] = { races = { 3 }, start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, obj = { { item = 274463, name = "Tattered Note", qty = 1, from = "Charlga Razorflank (33)", zone = "Razorfen Kraul", areaMin = 33 } } } -- Elemental Aid (level 33)
Q[97245] = { start = { npc = "Olariaan Swiftburn", zone = "Zephras Isle", x = 51.2, y = 86 }, finish = { npc = "Olariaan Swiftburn", zone = "Zephras Isle", x = 51.2, y = 86 }, obj = { { item = 277269, name = "Kuramaa's Mask", qty = 1, from = "Kuramaa", zone = "Zephras Isle", x = 42.4, y = 68.9 } } } -- Call of Fire (level 10)
Q[97257] = { start = { npc = "Olariaan Swiftburn", zone = "Zephras Isle", x = 51.2, y = 86 }, finish = { npc = "Sessaria Skystride", zone = "Zephras Isle", x = 58.2, y = 78.4 }, obj = { { item = 277329, name = "Torch of Eternal Flame", qty = 1 }, { kill = 268764, name = "Complete the Ritual with Olariaan", qty = 1 }, { kill = 268679, name = "Light the Brazier of Eternal Flame", qty = 1, from = "Brazier of Eternal Flame", zone = "Zephras Isle", x = 58.4, y = 78.8 } } } -- Call of Fire (level 10)
