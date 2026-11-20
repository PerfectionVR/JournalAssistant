-- Journal Assistant - Shaman class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.SHAMAN = {
    { key = "sha4earth", level = 4, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Earth (Earth Totem)", reward = "Stoneskin Totem, Earth Totem", spell = 8071,
      steps = { q(96243, "Call of Earth"), q(94373, "Call of Earth"), q(94374, "Call of Earth"), q(94375, "Call of Earth") },
      start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", note = "Anvilmar" }, confidence = "forever-guide" },
    { key = "sha10fire", level = 10, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Fire (Fire Totem)", reward = "Searing Totem, Fire Totem", spell = 3599,
      steps = { q(94449, "Call of Fire"), q(94465, "Call of Fire"), q(94466, "Call of Fire"), q(94467, "Call of Fire"), q(94468, "Call of Fire") },
      start = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", note = "cave above South Gate Outpost" }, confidence = "forever-guide" },
    { key = "sha20water", level = 20, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Water (Water Totem)", reward = "Healing Stream Totem, Water Totem", spell = 5394,
      steps = { n("Call of Water") }, start = { npc = "Norric Lochthane", zone = "Loch Modan", x = 41.9, y = 19.0 },
      zones = { "Wetlands" }, confidence = "unverified" },
    { key = "sha30air", level = 30, faction = "Alliance", races = { "Dwarf" },
      title = "Call of Air (Air Totem)", reward = "Air Totem, then a specialization weapon",
      steps = { q(94789, "Call of Air"), q(96264, "Elemental Aid"), q(79358, "Storm, Earth, and Fire"), q(96135, "Heed My Call"), q(96016, "The Tempest's Weapons") },
      start = { npc = "Veyric Thundervein", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, confidence = "forever-guide" },
    { key = "sha4earthh", level = 4, faction = "Horde",
      title = "Call of Earth (Earth Totem)", reward = "Stoneskin Totem, Earth Totem", spell = 8071,
      steps = { n("Call of Earth") }, start = { note = "from your Shaman trainer" }, confidence = "unverified" },
    { key = "sha10fireh", level = 10, faction = "Horde",
      title = "Call of Fire (Fire Totem)", reward = "Searing Totem, Fire Totem", spell = 3599,
      steps = { n("Call of Fire") }, start = { note = "from your Shaman trainer" }, confidence = "unverified" },
    { key = "sha20waterh", level = 20, faction = "Horde",
      title = "Call of Water (Water Totem)", reward = "Healing Stream Totem, Water Totem", spell = 5394,
      steps = { n("Call of Water") }, start = { note = "from your Shaman trainer" }, confidence = "unverified" },
    { key = "sha30airh", level = 30, faction = "Horde",
      title = "Call of Air (Air Totem)", reward = "Air Totem",
      steps = { n("Call of Air") }, start = { note = "from your Shaman trainer" }, confidence = "unverified" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[79358] = { races = { 3 }, start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, obj = { { item = 274046, name = "Twisted Water Totem", qty = 5, from = "Mirefin Warrior (37-38) / Mirefin Muckdweller (36-37)", zone = "Dustwallow Marsh", x = 61.6, y = 15.8, mapID = 1445, areaMin = 37 }, { item = 274045, name = "Twisted Earth Totem", qty = 5, from = "Lost One Mudlurker (34-35) / Lost One Fisherman (35-36)", area = 8, x = 46.8, y = 33.2, mapID = 1435, areaMin = 34 }, { item = 274044, name = "Twisted Fire Totem", qty = 5, from = "Dustbelcher Warrior (35-37) / Dustbelcher Mystic (36-37)", area = 3, x = 65.8, y = 23.8, mapID = 1418, areaMin = 35 }, { item = 274047, name = "Twisted Air Totem", qty = 5, from = "Maraudine Scout (37-38) / Maraudine Wrangler (37-38)", area = 405, x = 32.8, y = 60.4, mapID = 1443, areaMin = 37 } } } -- Storm, Earth, and Fire (level 43)
Q[94373] = { races = { 3 }, start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, obj = { { item = 264356, name = "Iceclaw Bear Pendant", qty = 2, from = "Frostmane Troll Whelp / Frostmane Novice", zone = "Dun Morogh", x = 27.6, y = 80.8 } } } -- Call of Earth (level 4)
Q[94374] = { races = { 3 }, start = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, finish = { npc = "Minor Manifestation of Earth", zone = "Dun Morogh", x = 24.8, y = 61.8 } } -- Call of Earth (level 4)
Q[94375] = { races = { 3 }, start = { npc = "Minor Manifestation of Earth", zone = "Dun Morogh", x = 24.8, y = 61.8 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 }, obj = { { item = 6656, name = "Rough Quartz", qty = 1 } } } -- Call of Earth (level 4)
Q[94449] = { races = { 3 }, start = { npc = "Ingrid Dunwald", zone = "Dun Morogh", x = 47.4, y = 52 }, finish = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", x = 87.6, y = 43.6 } } -- Call of Fire (level 10)
Q[94465] = { races = { 3 }, start = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", x = 87.6, y = 43.6 }, finish = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, obj = { { item = 6653, name = "Torch of the Dormant Flame", qty = 1 } } } -- Call of Fire (level 11)
Q[94466] = { races = { 3 }, start = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, finish = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, obj = { { item = 5026, name = "Fire Tar", qty = 1, from = "Tunnel Rat Geomancer", zone = "Loch Modan", x = 35, y = 23.4 }, { item = 6652, name = "Reagent Pouch", qty = 1, from = "Stonesplinter Seer", zone = "Loch Modan", x = 34, y = 85 } } } -- Call of Fire (level 14)
Q[94467] = { races = { 3 }, start = { npc = "Braldir Ashmantle", zone = "Loch Modan", x = 32, y = 66 }, finish = { npc = "Brazier of the Dormant Flame", zone = "Durotar", x = 38.9, y = 58.2 }, obj = { { item = 6653, name = "Torch of the Dormant Flame", qty = 1 }, { item = 6655, name = "Glowing Ember", qty = 1, from = "Minor Manifestation of Fire", zone = "Durotar", x = 38.6, y = 58.2 } } } -- Call of Fire (level 14)
Q[94468] = { races = { 3 }, start = { npc = "Brazier of the Dormant Flame", zone = "Durotar", x = 38.9, y = 58.2 }, finish = { npc = "Bruegs Kindleborn", zone = "Dun Morogh", x = 87.6, y = 43.6 }, obj = { { item = 6654, name = "Torch of the Eternal Flame", qty = 1 } } } -- Call of Fire (level 14)
Q[94789] = { races = { 3 }, start = { npc = "Eldrun Stormbreaker", zone = "Ironforge", x = 47.4, y = 13.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 } } -- Call of Air (level 30)
Q[96016] = { start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 212792, name = "Eye of the Tempest", qty = 1, from = "Ravaging Tempest (38-40)", zone = "Thousand Needles", x = 39.8, y = 39.7, mapID = 1441, areaMin = 38 } } } -- The Tempest's Weapons (level 40)
Q[96135] = { races = { 3 }, start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, obj = { { item = 212792, name = "Eye of the Tempest", qty = 1, from = "Ravaging Tempest (38-40)", zone = "Thousand Needles", x = 36.7, y = 39.5, areaMin = 38 }, { item = 268582, name = "Corrupted Totems", qty = 1 } } } -- Heed My Call (level 40)
Q[96243] = { races = { 3, 7, 95 }, start = { npc = "Ingrid Dunwald", zone = "Dun Morogh", x = 47.4, y = 52 }, finish = { npc = "Teo Hammerstorm", zone = "Dun Morogh", x = 28.8, y = 66.2 } } -- Call of Earth (level 4)
Q[96264] = { races = { 3 }, start = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, finish = { npc = "Veyric Thunderhame", zone = "Arathi Highlands", x = 59.8, y = 27.6 }, obj = { { item = 274463, name = "Tattered Note", qty = 1, from = "Charlga Razorflank (33)", zone = "Razorfen Kraul", areaMin = 33 } } } -- Elemental Aid (level 33)
