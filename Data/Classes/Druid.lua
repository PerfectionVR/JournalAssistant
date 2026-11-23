-- Journal Assistant - Druid class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q = D.QuestStep

-- Series, quest givers and races from wowhead.com/forever/quest=ID (2026-11-21).
-- alt = a second quest ID that does the same step (two quest givers).
D.classQuests.DRUID = {
    { key = "dru10bear", level = 10, faction = "Alliance", races = { "NightElf" },
      title = "Bear Form (Heeding the Call)", reward = "Bear Form, Growl, Maul", spell = 5487,
      steps = { { id = 5923, alt = { 5924 }, name = "Heeding the Call" }, q(5921, "Moonglade"), q(5929, "Great Bear Spirit"),
                q(5931, "Back to Darnassus"), q(6001, "Body and Heart") },
      start = { npc = "Denatharion", zone = "Darnassus", note = "or Theridran, Stormwind" },
      zones = { "Moonglade" }, confidence = "forever-guide" },
    { key = "dru10beart", level = 10, faction = "Horde", races = { "Tauren" },
      title = "Bear Form (Heeding the Call)", reward = "Bear Form, Growl, Maul", spell = 5487,
      steps = { { id = 5926, alt = { 5927 }, name = "Heeding the Call" }, q(5922, "Moonglade"), q(5930, "Great Bear Spirit"),
                q(5932, "Back to Thunder Bluff"), q(6002, "Body and Heart") },
      start = { npc = "Innkeeper Pala", zone = "Thunder Bluff", note = "or Innkeeper Gryshka, Orgrimmar" },
      zones = { "Moonglade" }, confidence = "forever-guide" },
    { key = "dru10bearsky", level = 10, races = { "Skyborne" },
      title = "Bear Form (The Great Ursera Spirit)", reward = "Bear Form", spell = 5487,
      steps = { q(94006, "The Great Ursera Spirit"), q(94638, "Strength and Mercy") },
      start = { npc = "Lotheluum Starbreeze", note = "Valanaar, Zephras Isle" }, confidence = "forever-guide" },
    { key = "dru10mg", level = 10, faction = "Alliance", races = { "Skyborne" },
      title = "Teleport: Moonglade", reward = "Teleport: Moonglade", spell = 18960,
      steps = { q(94914, "Moonglade") }, start = { npc = "Sheldras Moontree", zone = "Stormwind City", x = 36.0, y = 67.3 },
      zones = { "Moonglade" }, confidence = "forever-guide" },
    { key = "dru10mgh", level = 10, faction = "Horde", races = { "Skyborne" },
      title = "Teleport: Moonglade", reward = "Teleport: Moonglade", spell = 18960,
      steps = { q(94913, "Moonglade") }, start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.6, y = 27.6 },
      zones = { "Moonglade" }, confidence = "forever-guide" },
    { key = "dru14cure", level = 14, faction = "Alliance",
      title = "Cure Poison (Lessons Anew)", reward = "Cure Poison", spell = 8946,
      steps = { q(6121, "Lessons Anew"), q(6122, "The Principal Source"), q(6123, "Gathering the Cure"),
                q(6124, "Curing the Sick"), q(6125, "Power over Poison") },
      start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus" }, zones = { "Moonglade", "Darkshore" }, confidence = "forever-guide" },
    { key = "dru14cureh", level = 14, faction = "Horde",
      title = "Cure Poison (Lessons Anew)", reward = "Cure Poison", spell = 8946,
      steps = { q(6126, "Lessons Anew"), q(6127, "The Principal Source"), q(6128, "Gathering the Cure"),
                q(6129, "Curing the Sick"), q(6130, "Power over Poison") },
      start = { npc = "Turak Runetotem", zone = "Thunder Bluff" }, zones = { "Moonglade", "Mulgore" }, confidence = "forever-guide" },
    { key = "dru16aqua", level = 16, faction = "Alliance",
      title = "Aquatic Form", reward = "Aquatic Form, Aquarius Belt", spell = 1066,
      steps = { q(26, "A Lesson to Learn"), q(29, "Trial of the Lake"), q(272, "Trial of the Sea Lion"), q(5061, "Aquatic Form") },
      start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus" }, zones = { "Moonglade", "Darkshore" }, confidence = "forever-guide" },
    { key = "dru16aquah", level = 16, faction = "Horde",
      title = "Aquatic Form", reward = "Aquatic Form, Aquarius Belt", spell = 1066,
      steps = { q(27, "A Lesson to Learn"), q(28, "Trial of the Lake"), q(30, "Trial of the Sea Lion"), q(31, "Aquatic Form") },
      start = { npc = "Turak Runetotem", zone = "Thunder Bluff" }, zones = { "Moonglade", "The Barrens" }, confidence = "forever-guide" },
    { key = "dru20cat", level = 20, faction = "Alliance", races = { "NightElf" },
      title = "Cat Form (The Great Cat Spirit)", reward = "Cat Form, Claw, Prowl, Rip", spell = 768,
      steps = { q(98393, "The Great Cat Spirit"), q(98394, "The Great Cat Spirit"), q(98396, "The Great Cat Spirit"),
                q(98731, "Blessings of the Great Cat Spirit"), q(98397, "To Darnassus") },
      start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus" }, zones = { "Moonglade" }, confidence = "forever-guide" },
    { key = "dru20catsky", level = 20, faction = "Alliance", races = { "Skyborne" },
      title = "Cat Form (The Great Windborne Cat Spirit)", reward = "Cat Form, Claw, Prowl, Rip", spell = 768,
      steps = { q(98393, "The Great Cat Spirit"), q(98341, "The Great Windborne Cat Spirit"), q(98397, "To Darnassus") },
      start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus" }, zones = { "Moonglade" }, confidence = "forever-guide" },
    { key = "dru20cath", level = 20, faction = "Horde", races = { "Tauren" },
      title = "Cat Form (The Great Cat Spirit)", reward = "Cat Form, Claw, Prowl, Rip", spell = 768,
      steps = { q(98340, "The Great Cat Spirit"), q(98405, "The Great Cat Spirit"), q(98342, "The Great Cat Spirit"),
                q(98739, "Blessings of the Great Cat Spirit"), q(98362, "To Thunder Bluff") },
      start = { npc = "Turak Runetotem", zone = "Thunder Bluff" }, zones = { "Moonglade" }, confidence = "forever-guide" },
    -- the Horde quests around 98341 are Tauren-only on Wowhead
    { key = "dru20catskyh", level = 20, faction = "Horde", races = { "Skyborne" },
      title = "Cat Form (The Great Windborne Cat Spirit)", reward = "Cat Form, Claw, Prowl, Rip", spell = 768,
      steps = { q(98341, "The Great Windborne Cat Spirit") },
      start = { npc = "Dendrite Starblaze", zone = "Moonglade" }, confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[26] = { races = { 4, 95 }, start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- A Lesson to Learn (level 16)
Q[27] = { races = { 6 }, start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- A Lesson to Learn (level 16)
Q[28] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Tajarri", zone = "Moonglade", x = 36.4, y = 40.2 }, obj = { { item = 15877, name = "Shrine Bauble", qty = 1, from = "Bauble Container", zone = "Moonglade", x = 54.9, y = 52.2, mapID = 1450 } } } -- Trial of the Lake (level 16)
Q[29] = { races = { 4, 95 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Tajarri", zone = "Moonglade", x = 36.4, y = 40.2 }, obj = { { item = 15877, name = "Shrine Bauble", qty = 1, from = "Bauble Container", zone = "Moonglade", x = 54.9, y = 52.2, mapID = 1450 } } } -- Trial of the Lake (level 16)
Q[30] = { races = { 6 }, start = { npc = "Tajarri", zone = "Moonglade", x = 36.4, y = 40.2 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, obj = { { item = 15885, name = "Pendant of the Sea Lion", qty = 1 }, { item = 15883, name = "Half Pendant of Aquatic Agility", qty = 1, from = "Strange Lockbox / Strange Lockbox", zone = "The Barrens", x = 56.7, y = 8.3, mapID = 1413 }, { item = 15882, name = "Half Pendant of Aquatic Endurance", qty = 1, from = "Strange Lockbox / Strange Lockbox", zone = "Silverpine Forest", x = 29.6, y = 29.5, mapID = 1421 } } } -- Trial of the Sea Lion (level 16)
Q[31] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, obj = { { item = 15885, name = "Pendant of the Sea Lion", qty = 1 } } } -- Aquatic Form (level 16)
Q[272] = { races = { 4, 95 }, start = { npc = "Tajarri", zone = "Moonglade", x = 36.4, y = 40.2 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, obj = { { item = 15885, name = "Pendant of the Sea Lion", qty = 1 }, { item = 15883, name = "Half Pendant of Aquatic Agility", qty = 1, from = "Strange Lockbox / Strange Lockbox", zone = "The Barrens", x = 56.7, y = 8.3, mapID = 1413 }, { item = 15882, name = "Half Pendant of Aquatic Endurance", qty = 1, from = "Strange Lockbox / Strange Lockbox", zone = "Silverpine Forest", x = 29.6, y = 29.5, mapID = 1421 } } } -- Trial of the Sea Lion (level 16)
Q[5061] = { races = { 4, 95 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 }, obj = { { item = 15885, name = "Pendant of the Sea Lion", qty = 1 } } } -- Aquatic Form (level 16)
Q[5921] = { races = { 4 }, start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Moonglade (level 10)
Q[5922] = { races = { 6 }, start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Moonglade (level 10)
Q[5923] = { races = { 4 }, start = { npc = "Denatharion", zone = "Darnassus", x = 34.8, y = 7.8 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 } } -- Heeding the Call (level 10)
Q[5924] = { races = { 4 }, start = { npc = "Theridran", zone = "Stormwind City", x = 36.2, y = 64.2 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 } } -- Heeding the Call (level 10)
Q[5926] = { races = { 6 }, start = { npc = "Innkeeper Pala", zone = "Thunder Bluff", x = 45.8, y = 64.4 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 } } -- Heeding the Call (level 10)
Q[5927] = { races = { 6 }, start = { npc = "Innkeeper Gryshka", zone = "Orgrimmar", x = 54, y = 68.6 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 } } -- Heeding the Call (level 10)
Q[5929] = { races = { 4 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Great Bear Spirit (level 10)
Q[5930] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Great Bear Spirit (level 10)
Q[5931] = { races = { 4 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 } } -- Back to Darnassus (level 10)
Q[5932] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 } } -- Back to Thunder Bluff (level 10)
Q[6001] = { races = { 4 }, start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 } } -- Body and Heart (level 10)
Q[6002] = { races = { 6 }, start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 } } -- Body and Heart (level 10)
Q[6121] = { races = { 4, 95 }, start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Lessons Anew (level 14)
Q[6122] = { races = { 4, 95 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Alanndarian Nightsong", zone = "Darkshore", x = 37.6, y = 40.6 }, obj = { { item = 15845, name = "Filled Cliffspring Falls Sampler", qty = 1 } } } -- The Principal Source (level 14)
Q[6123] = { races = { 4, 95 }, start = { npc = "Alanndarian Nightsong", zone = "Darkshore", x = 37.6, y = 40.6 }, finish = { npc = "Alanndarian Nightsong", zone = "Darkshore", x = 37.6, y = 40.6 }, obj = { { item = 2449, name = "Earthroot", qty = 5, from = "Battered Chest", zone = "Darkshore", x = 36.3, y = 86.5 }, { item = 15851, name = "Lunar Fungus", qty = 12, from = "Lunar Fungal Bloom", zone = "Darkshore", x = 44.2, y = 49.7, mapID = 1439 } } } -- Gathering the Cure (level 14)
Q[6124] = { races = { 4, 95 }, start = { npc = "Alanndarian Nightsong", zone = "Darkshore", x = 37.6, y = 40.6 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, obj = { { kill = 12299, name = "Sickly Deer cured", qty = 10 } } } -- Curing the Sick (level 14)
Q[6125] = { races = { 4, 95 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 } } -- Power over Poison (level 14)
-- Wowhead "Requires Any" lists 5926; 5927 (Orgrimmar) "Unlocks" it too
Q[6126] = { races = { 6 }, requiresOneOf = { { 5926, "Heeding the Call" }, { 5927, "Heeding the Call" } }, start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Lessons Anew (level 14)
Q[6127] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Tonga Runetotem", zone = "The Barrens", x = 52.2, y = 31.8 }, obj = { { item = 15843, name = "Filled Dreadmist Peak Sampler", qty = 1 } } } -- The Principal Source (level 14)
Q[6128] = { races = { 6 }, start = { npc = "Tonga Runetotem", zone = "The Barrens", x = 52.2, y = 31.8 }, finish = { npc = "Tonga Runetotem", zone = "The Barrens", x = 52.2, y = 31.8 }, obj = { { item = 2449, name = "Earthroot", qty = 5, from = "Earthroot / Battered Chest / Alliance Chest", zone = "The Barrens", x = 50.3, y = 21.8 }, { item = 15852, name = "Kodo Horn", qty = 5, from = "Lost Barrens Kodo / Barrens Kodo", zone = "The Barrens", x = 52.5, y = 13.5 } } } -- Gathering the Cure (level 14)
Q[6129] = { races = { 6 }, start = { npc = "Tonga Runetotem", zone = "The Barrens", x = 52.2, y = 31.8 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, obj = { { kill = 12297, name = "Sickly Gazelle cured", qty = 10 } } } -- Curing the Sick (level 14)
Q[6130] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 } } -- Power over Poison (level 14)
Q[94006] = { races = { 95 }, start = { npc = "Lotheluum Starbreeze", zone = "Zephras Isle", x = 64, y = 75 }, finish = { npc = "Urs'endris", zone = "Zephras Isle", x = 69.8, y = 61.6 } } -- The Great Ursera Spirit (level 10)
Q[94638] = { races = { 95 }, start = { npc = "Urs'endris", zone = "Zephras Isle", x = 69.8, y = 61.6 }, finish = { npc = "Urs'endris", zone = "Zephras Isle", x = 69.8, y = 61.6 }, obj = { { kill = 258443, name = "Ur'endra", qty = 1, zone = "Zephras Isle", x = 54, y = 65.4 } } } -- Strength and Mercy (level 10)
Q[94913] = { start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Moonglade (level 10)
Q[94914] = { races = { 95 }, start = { npc = "Sheldras Moontree", zone = "Stormwind City", x = 36, y = 67.2 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Moonglade (level 10)
Q[98340] = { races = { 6 }, start = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- The Great Cat Spirit (level 20)
Q[98341] = { races = { 95 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Avatar of Saeyleenan", zone = "Moonglade", x = 43.9, y = 73.4 } } -- The Great Windborne Cat Spirit (level 20)
Q[98342] = { races = { 6 }, start = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 }, finish = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 }, obj = { { item = 280502, name = "Relic of the Fang", qty = 1, from = "Relic of the Fang", zone = "Moonglade", x = 72.5, y = 66, mapID = 1450 }, { item = 280679, name = "Relic of the Claw", qty = 1, from = "Relic of the Claw", zone = "Moonglade", x = 75.3, y = 67.4, mapID = 1450 }, { item = 280680, name = "Relic of the Silent Shadow", qty = 1, from = "Relic of the Silent Shadow", zone = "Moonglade", x = 74.5, y = 65.4, mapID = 1450 } } } -- The Great Cat Spirit (level 20)
Q[98362] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Turak Runetotem", zone = "Thunder Bluff", x = 76.4, y = 27.6 } } -- To Thunder Bluff (level 20)
Q[98393] = { races = { 4, 95 }, start = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- The Great Cat Spirit (level 20)
Q[98394] = { races = { 4 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 } } -- The Great Cat Spirit (level 20)
Q[98396] = { races = { 4 }, start = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 }, finish = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 }, obj = { { item = 280502, name = "Relic of the Fang", qty = 1 }, { item = 280679, name = "Relic of the Claw", qty = 1 }, { item = 280680, name = "Relic of the Silent Shadow", qty = 1 } } } -- The Great Cat Spirit (level 20)
Q[98397] = { races = { 4, 95 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Mathrengyl Bearwalker", zone = "Darnassus", x = 35.2, y = 8 } } -- To Darnassus (level 20)
Q[98405] = { races = { 6 }, start = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 }, finish = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 } } -- The Great Cat Spirit (level 20)
Q[98731] = { races = { 4 }, start = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Blessings of the Great Cat Spirit (level 20)
Q[98739] = { races = { 6 }, start = { npc = "Great Cat Spirit", zone = "Moonglade", x = 54.6, y = 75 }, finish = { npc = "Dendrite Starblaze", zone = "Moonglade", x = 56.2, y = 30.4 } } -- Blessings of the Great Cat Spirit (level 20)
