-- Journal Assistant - Warlock class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.
--
-- Every quest ID, step order (Wowhead "Series"), quest giver, race and
-- prerequisite was read from wowhead.com/forever/quest=ID on 2026-11-21.
-- One chain per race where the races start in different places.

local _, ns = ...
local D = ns.Data
local q = D.QuestStep

D.classQuests.WARLOCK = {
    -- level 10: Voidwalker
    { key = "wl10void", level = 10, faction = "Alliance", races = { "Human" },
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { q(1685, "Gakin's Summons"), q(1688, "Surena Caledon"), q(1689, "The Binding") },
      start = { npc = "Remen Marcot", zone = "Elwynn Forest", note = "Goldshire" }, confidence = "forever-guide" },
    { key = "wl10voidg", level = 10, faction = "Alliance", races = { "Gnome" },
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { q(1715, "The Slaughtered Lamb"), q(1688, "Surena Caledon"), q(1689, "The Binding") },
      start = { npc = "Lago Blackwrench", zone = "Ironforge" }, zones = { "Stormwind City", "Elwynn Forest" }, confidence = "forever-guide" },
    { key = "wl10voidu", level = 10, faction = "Horde", races = { "Scourge" },
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { q(1478, "Halgar's Summons"), q(1473, "Creature of the Void"), q(1471, "The Binding") },
      start = { npc = "Ageron Kargal", zone = "Tirisfal Glades", note = "Brill" }, confidence = "forever-guide" },
    { key = "wl10voido", level = 10, faction = "Horde", races = { "Orc" },
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { q(1506, "Gan'rul's Summons"), q(1501, "Creature of the Void"), q(1504, "The Binding") },
      start = { npc = "Ophek", zone = "Durotar", note = "Razor Hill" }, confidence = "forever-guide" },
    -- level 20: Succubus
    { key = "wl20succ", level = 20, faction = "Alliance",
      title = "Summon Succubus", reward = "Summon Succubus", spell = 712,
      steps = { q(1717, "Gakin's Summons"), q(1716, "Devourer of Souls"), q(1738, "Heartswood"), q(1739, "The Binding") },
      start = { npc = "Lago Blackwrench", zone = "Ironforge" }, zones = { "Stormwind City", "The Barrens" }, confidence = "forever-guide" },
    { key = "wl20succu", level = 20, faction = "Horde", races = { "Scourge" },
      title = "Summon Succubus", reward = "Summon Succubus", spell = 712,
      steps = { q(1472, "Devourer of Souls"), q(1508, "Blind Cazul"), q(1509, "News of Dogran"), q(1510, "News of Dogran"),
                q(1511, "Ken'zigla's Draught"), q(1515, "Dogran's Captivity"), q(1512, "Love's Gift"), q(1513, "The Binding") },
      start = { npc = "Carendin Halgar", zone = "Undercity" },
      zones = { "Orgrimmar", "The Barrens", "Stonetalon Mountains" }, confidence = "forever-guide" },
    { key = "wl20succo", level = 20, faction = "Horde", races = { "Orc" },
      title = "Summon Succubus", reward = "Summon Succubus", spell = 712,
      steps = { q(1507, "Devourer of Souls"), q(1508, "Blind Cazul"), q(1509, "News of Dogran"), q(1510, "News of Dogran"),
                q(1511, "Ken'zigla's Draught"), q(1515, "Dogran's Captivity"), q(1512, "Love's Gift"), q(1513, "The Binding") },
      start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar" },
      zones = { "The Barrens", "Stonetalon Mountains" }, confidence = "forever-guide" },
    { key = "wl20orb", level = 20, optional = true,
      title = "The Orb of Soran'ruk", reward = "Staff or Orb of Soran'ruk",
      steps = { q(1740, "The Orb of Soran'ruk") }, start = { npc = "Doan Karhan", zone = "The Barrens" },
      note = "Needs fragments from Blackfathom Deeps and Shadowfang Keep.", confidence = "forever-guide" },
    -- level 30: Felhunter
    { key = "wl30fel", level = 30, faction = "Alliance",
      title = "Summon Felhunter", reward = "Summon Felhunter", spell = 691,
      steps = { q(1798, "Seeking Strahad"), q(1758, "Tome of the Cabal"), q(1802, "Tome of the Cabal"),
                q(1804, "Tome of the Cabal"), q(1795, "The Binding") },
      start = { npc = "Lago Blackwrench", zone = "Ironforge", note = "or Gakin the Darkbinder, Stormwind" },
      zones = { "The Barrens", "Ironforge", "Wetlands" }, confidence = "forever-guide" },
    { key = "wl30felu", level = 30, faction = "Horde", races = { "Scourge" },
      title = "Summon Felhunter", reward = "Summon Felhunter", spell = 691,
      steps = { q(3001, "Seeking Strahad"), q(1801, "Tome of the Cabal"), q(1803, "Tome of the Cabal"),
                q(1805, "Tome of the Cabal"), q(1795, "The Binding") },
      start = { npc = "Carendin Halgar", zone = "Undercity" },
      zones = { "The Barrens", "Undercity", "Wetlands" }, confidence = "forever-guide" },
    { key = "wl30felo", level = 30, faction = "Horde", races = { "Orc" },
      title = "Summon Felhunter", reward = "Summon Felhunter", spell = 691,
      steps = { q(2996, "Seeking Strahad"), q(1801, "Tome of the Cabal"), q(1803, "Tome of the Cabal"),
                q(1805, "Tome of the Cabal"), q(1795, "The Binding") },
      start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar" },
      zones = { "The Barrens", "Undercity", "Wetlands" }, confidence = "forever-guide" },
    -- level 40: Felsteed
    { key = "wl40steed", level = 40, faction = "Alliance", races = { "Human" },
      title = "Summon Felsteed (mount)", reward = "Summon Felsteed", spell = 5784,
      steps = { q(4488, "Summon Felsteed"), q(4490, "Summon Felsteed") },
      start = { npc = "Demisette Cloyce", zone = "Stormwind City" }, zones = { "The Barrens" }, confidence = "forever-guide" },
    { key = "wl40steedg", level = 40, faction = "Alliance", races = { "Gnome" },
      title = "Summon Felsteed (mount)", reward = "Summon Felsteed", spell = 5784,
      steps = { q(4487, "Summon Felsteed"), q(4490, "Summon Felsteed") },
      start = { npc = "Briarthorn", zone = "Ironforge" }, zones = { "The Barrens" }, confidence = "forever-guide" },
    { key = "wl40steedu", level = 40, faction = "Horde", races = { "Scourge" },
      title = "Summon Felsteed (mount)", reward = "Summon Felsteed", spell = 5784,
      steps = { q(4489, "Summon Felsteed"), q(4490, "Summon Felsteed") },
      start = { npc = "Kaal Soulreaper", zone = "Undercity" }, zones = { "The Barrens" }, confidence = "forever-guide" },
    { key = "wl40steedo", level = 40, faction = "Horde", races = { "Orc" },
      title = "Summon Felsteed (mount)", reward = "Summon Felsteed", spell = 5784,
      steps = { q(3631, "Summon Felsteed"), q(4490, "Summon Felsteed") },
      start = { npc = "Zevrost", zone = "Orgrimmar" }, zones = { "The Barrens" }, confidence = "forever-guide" },
    -- level 50: Impsy (Felwood)
    { key = "wl50impsy", level = 50, optional = true,
      title = "Impsy (Felwood)", reward = "see the quests on Wowhead",
      steps = { q(8419, "An Imp's Request"), q(8420, "Hot and Itchy"), q(8421, "The Wrong Stuff"), q(8422, "Trolls of a Feather") },
      start = { note = "from your capital's warlock trainer area" }, zones = { "Felwood" }, confidence = "forever-guide" },
    -- level 60: Dreadsteed
    { key = "wl60dread", level = 60,
      title = "Summon Dreadsteed (epic mount)", reward = "Summon Dreadsteed", spell = 23161,
      steps = { q(7562, "Mor'zul Bloodbringer"), q(7563, "Rage of Blood"), q(7564, "Wildeyes"),
                q(7623, "Lord Banehollow"), q(7624, "Ulathek the Traitor"), q(7625, "Xorothian Stardust"),
                q(7626, "Bell of Dethmoora"), q(7630, "Arcanite"), q(7629, "Imp Delivery"), q(7631, "Dreadsteed of Xoroth") },
      start = { note = "from your capital's warlock trainer area" },
      zones = { "Burning Steppes", "Felwood", "Scholomance", "Dire Maul" }, confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[1471] = { races = { 2, 5 }, start = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 }, finish = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 }, obj = { { kill = 5676, name = "Summoned Voidwalker", qty = 1, zone = "Undercity", x = 86.7, y = 27 }, { item = 6284, name = "Runes of Summoning", qty = 1 } } } -- The Binding (level 10)
Q[1472] = { races = { 2, 5 }, start = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 }, finish = { npc = "Godrick Farsan", zone = "Undercity", x = 85, y = 14.8 } } -- Devourer of Souls (level 20)
Q[1473] = { races = { 2, 5 }, start = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 }, finish = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 }, obj = { { item = 6285, name = "Egalin's Grimoire", qty = 1 } } } -- Creature of the Void (level 10)
Q[1478] = { races = { 2, 5 }, start = { npc = "Ageron Kargal", zone = "Tirisfal Glades", x = 61.6, y = 52.6 }, finish = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 } } -- Halgar's Summons (level 10)
Q[1501] = { races = { 2, 5 }, start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, finish = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, obj = { { item = 6535, name = "Tablet of Verga", qty = 1 } } } -- Creature of the Void (level 11)
Q[1504] = { races = { 2, 5 }, start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, finish = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, obj = { { kill = 5676, name = "Summoned Voidwalker", qty = 1, zone = "Orgrimmar", x = 49.4, y = 50 }, { item = 7464, name = "Glyphs of Summoning", qty = 1 } } } -- The Binding (level 11)
Q[1506] = { races = { 2, 5 }, start = { npc = "Ophek", zone = "Durotar", x = 54.2, y = 41.2 }, finish = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 } } -- Gan'rul's Summons (level 10)
Q[1507] = { races = { 2, 5 }, start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, finish = { npc = "Cazul", zone = "Orgrimmar", x = 47.2, y = 46.6 } } -- Devourer of Souls (level 20)
-- Blind Cazul: Wowhead lists 1472 under "Requires Any"; 1507 (Orc) "Unlocks" it too
Q[1508] = { races = { 2, 5 }, requiresOneOf = { { 1472, "Devourer of Souls" }, { 1507, "Devourer of Souls" } }, start = { npc = "Cazul", zone = "Orgrimmar", x = 47.2, y = 46.6 }, finish = { npc = "Zankaja", zone = "Orgrimmar", x = 37, y = 59.6 } } -- Blind Cazul (level 20)
Q[1509] = { races = { 2, 5 }, start = { npc = "Zankaja", zone = "Orgrimmar", x = 37, y = 59.6 }, finish = { npc = "Gazrog", zone = "The Barrens", x = 51.8, y = 30.2 } } -- News of Dogran (level 20)
Q[1510] = { races = { 2, 5 }, start = { npc = "Gazrog", zone = "The Barrens", x = 51.8, y = 30.2 }, finish = { npc = "Ken'zigla", zone = "Stonetalon Mountains", x = 73.2, y = 95 } } -- News of Dogran (level 20)
Q[1511] = { races = { 2, 5 }, start = { npc = "Ken'zigla", zone = "Stonetalon Mountains", x = 73.2, y = 95 }, finish = { npc = "Grunt Logmar", zone = "The Barrens", x = 44.6, y = 59.2 }, obj = { { item = 6624, name = "Ken'zigla's Draught", qty = 1 } } } -- Ken'zigla's Draught (level 20)
Q[1512] = { races = { 2, 5 }, start = { npc = "Grunt Dogran", zone = "The Barrens", x = 43.2, y = 47.8 }, finish = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, obj = { { item = 6625, name = "Dirt-caked Pendant", qty = 1 } } } -- Love's Gift (level 20)
Q[1513] = { races = { 2, 5 }, start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, finish = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, obj = { { kill = 5677, name = "Summoned Succubus", qty = 1, zone = "Orgrimmar", x = 49.4, y = 50 }, { item = 6626, name = "Dogran's Pendant", qty = 1 } } } -- The Binding (level 20)
Q[1515] = { races = { 2, 5 }, start = { npc = "Grunt Logmar", zone = "The Barrens", x = 44.6, y = 59.2 }, finish = { npc = "Grunt Dogran", zone = "The Barrens", x = 43.2, y = 47.8 }, obj = { { item = 6624, name = "Ken'zigla's Draught", qty = 1 } } } -- Dogran's Captivity (level 20)
Q[1685] = { races = { 1, 7 }, start = { npc = "Remen Marcot", zone = "Elwynn Forest", x = 44.4, y = 66.2 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 } } -- Gakin's Summons (level 10)
Q[1688] = { races = { 1, 7 }, start = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, obj = { { item = 6810, name = "Surena's Choker", qty = 1, from = "Surena Caledon", zone = "Elwynn Forest", x = 71, y = 80.6 } } } -- Surena Caledon (level 10)
Q[1689] = { races = { 1, 7 }, start = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, obj = { { kill = 5676, name = "Summoned Voidwalker", qty = 1, zone = "Stormwind City", x = 39.1, y = 84.3 }, { item = 6928, name = "Bloodstone Choker", qty = 1 } } } -- The Binding (level 10)
Q[1715] = { races = { 1, 7 }, start = { npc = "Lago Blackwrench", zone = "Ironforge", x = 47.6, y = 9.6 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 } } -- The Slaughtered Lamb (level 10)
Q[1716] = { races = { 1, 7 }, start = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, finish = { npc = "Takar the Seer", zone = "The Barrens", x = 49.2, y = 57 } } -- Devourer of Souls (level 20)
Q[1717] = { races = { 1, 7 }, start = { npc = "Lago Blackwrench", zone = "Ironforge", x = 47.6, y = 9.6 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 } } -- Gakin's Summons (level 20)
Q[1738] = { races = { 1, 7 }, requires = { { 1716, "Devourer of Souls" } }, start = { npc = "Takar the Seer", zone = "The Barrens", x = 49.2, y = 57 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, obj = { { item = 6912, name = "Heartswood", qty = 1 } } } -- Heartswood (level 20)
Q[1739] = { races = { 1, 7 }, start = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, finish = { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 }, obj = { { kill = 5677, name = "Summoned Succubus", qty = 1, zone = "Stormwind City", x = 39.1, y = 84.3 }, { item = 6913, name = "Heartswood Core", qty = 1 } } } -- The Binding (level 20)
Q[1740] = { start = { npc = "Doan Karhan", zone = "The Barrens", x = 49.2, y = 57.2 }, finish = { npc = "Doan Karhan", zone = "The Barrens", x = 49.2, y = 57.2 }, obj = { { item = 6914, name = "Soran'ruk Fragment", qty = 3, from = "Twilight Acolyte", zone = "Blackfathom Deeps" }, { item = 6915, name = "Large Soran'ruk Fragment", qty = 1, from = "Shadowfang Darksoul", zone = "Shadowfang Keep" } } } -- The Orb of Soran'ruk (level 25)
Q[1758] = { races = { 1, 7 }, start = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, finish = { npc = "Krom Stoutarm", zone = "Ironforge", x = 74.2, y = 9.8 } } -- Tome of the Cabal (level 30)
-- The Binding: Wowhead lists 1804 (Alliance) under "Requires"; Horde warlocks reach it through 1805
Q[1795] = { requiresOneOf = { { 1804, "Tome of the Cabal" }, { 1805, "Tome of the Cabal" } }, start = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, obj = { { kill = 6268, name = "Summoned Felhunter", qty = 1, zone = "The Barrens", x = 62.6, y = 35.2 }, { item = 6999, name = "Tome of the Cabal", qty = 1 } } } -- The Binding (level 30)
Q[1798] = { races = { 1, 7 }, starts = { { npc = "Lago Blackwrench", zone = "Ironforge", x = 47.6, y = 9.6, races = { 7 } }, { npc = "Gakin the Darkbinder", zone = "Stormwind City", x = 39.2, y = 85.2 } }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Seeking Strahad (level 30)
Q[1801] = { races = { 2, 5 }, start = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, finish = { npc = "Jorah Annison", zone = "Undercity", x = 76, y = 37.6 } } -- Tome of the Cabal (level 30)
Q[1802] = { races = { 1, 7 }, start = { npc = "Krom Stoutarm", zone = "Ironforge", x = 74.2, y = 9.8 }, finish = { npc = "Krom Stoutarm", zone = "Ironforge", x = 74.2, y = 9.8 }, obj = { { item = 6931, name = "Moldy Tome", qty = 1 }, { item = 6997, name = "Tattered Manuscript", qty = 1 } } } -- Tome of the Cabal (level 30)
Q[1803] = { races = { 2, 5 }, start = { npc = "Jorah Annison", zone = "Undercity", x = 76, y = 37.6 }, finish = { npc = "Jorah Annison", zone = "Undercity", x = 76, y = 37.6 }, obj = { { item = 6931, name = "Moldy Tome", qty = 1 }, { item = 6997, name = "Tattered Manuscript", qty = 1 } } } -- Tome of the Cabal (level 30)
Q[1804] = { races = { 1, 7 }, start = { npc = "Krom Stoutarm", zone = "Ironforge", x = 74.2, y = 9.8 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, obj = { { item = 7006, name = "Reconstructed Tome", qty = 1 }, { item = 6930, name = "Rod of Channeling", qty = 3, from = "Dragonmaw Shadowwarder / Dragonmaw Bonewarder", zone = "Wetlands", x = 49.2, y = 47.2 } } } -- Tome of the Cabal (level 30)
Q[1805] = { races = { 2, 5 }, start = { npc = "Jorah Annison", zone = "Undercity", x = 76, y = 37.6 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, obj = { { item = 7006, name = "Reconstructed Tome", qty = 1 }, { item = 6930, name = "Rod of Channeling", qty = 3, from = "Dragonmaw Shadowwarder / Dragonmaw Bonewarder", zone = "Wetlands", x = 49.2, y = 47.2 } } } -- Tome of the Cabal (level 30)
Q[2996] = { races = { 2, 5 }, start = { npc = "Gan'rul Bloodeye", zone = "Orgrimmar", x = 48.2, y = 45.6 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Seeking Strahad (level 30)
Q[3001] = { races = { 2, 5 }, start = { npc = "Carendin Halgar", zone = "Undercity", x = 85, y = 25.6 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Seeking Strahad (level 30)
Q[3631] = { races = { 2, 5 }, start = { npc = "Zevrost", zone = "Orgrimmar", x = 48.2, y = 45.6 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Summon Felsteed (level 40)
Q[4487] = { races = { 1, 7 }, start = { npc = "Briarthorn", zone = "Ironforge", x = 50.2, y = 6 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Summon Felsteed (level 40)
Q[4488] = { races = { 1, 7 }, start = { npc = "Demisette Cloyce", zone = "Stormwind City", x = 39.2, y = 85 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Summon Felsteed (level 40)
Q[4489] = { races = { 2, 5 }, start = { npc = "Kaal Soulreaper", zone = "Undercity", x = 86, y = 15.6 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Summon Felsteed (level 40)
Q[4490] = { start = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 }, finish = { npc = "Strahad Farsan", zone = "The Barrens", x = 62.6, y = 35.4 } } -- Summon Felsteed (level 40)
Q[7562] = { starts = { { npc = "Spackle Thornberry", zone = "Stormwind City", x = 39.6, y = 84.4, faction = "Alliance", races = { 1 } }, { npc = "Jubahl Corpseseeker", zone = "Ironforge", x = 53, y = 6.2, faction = "Alliance" }, { npc = "Kurgul", zone = "Orgrimmar", x = 47.6, y = 46.8, faction = "Horde", races = { 2 } }, { npc = "Martha Strain", zone = "Undercity", x = 85.8, y = 15.6, faction = "Horde" } }, finish = { npc = "Mor'zul Bloodbringer", zone = "Burning Steppes", x = 12.6, y = 31.6 } } -- Mor'zul Bloodbringer (level 58)
Q[7563] = { start = { npc = "Mor'zul Bloodbringer", zone = "Burning Steppes", x = 12.6, y = 31.6 }, finish = { npc = "Mor'zul Bloodbringer", zone = "Burning Steppes", x = 12.6, y = 31.6 }, obj = { { item = 18590, name = "Raging Beast's Blood", qty = 30 } } } -- Rage of Blood (level 58)
Q[7564] = { start = { npc = "Mor'zul Bloodbringer", zone = "Burning Steppes", x = 12.6, y = 31.6 }, finish = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, obj = { { item = 18591, name = "Case of Blood", qty = 1 } } } -- Wildeyes (level 58)
Q[7623] = { requires = { { 7564, "Wildeyes" } }, start = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, finish = { npc = "Lord Banehollow", zone = "Felwood", x = 36, y = 44.6 } } -- Lord Banehollow (level 58)
Q[7624] = { start = { npc = "Lord Banehollow", zone = "Felwood", x = 36, y = 44.6 }, finish = { npc = "Lord Banehollow", zone = "Felwood", x = 36, y = 44.6 }, obj = { { item = 18719, name = "The Traitor's Heart", qty = 1, from = "Ulathek", zone = "Felwood", x = 40.6, y = 48.4 } } } -- Ulathek the Traitor (level 58)
Q[7625] = { start = { npc = "Lord Banehollow", zone = "Felwood", x = 36, y = 44.6 }, finish = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, obj = { { item = 18687, name = "Xorothian Stardust", qty = 1 } } } -- Xorothian Stardust (level 60)
Q[7626] = { requires = { { 7564, "Wildeyes" } }, start = { npc = "Mor'zul Bloodbringer", zone = "Burning Steppes", x = 12.6, y = 31.6 }, finish = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, obj = { { item = 9264, name = "Elixir of Shadow Power", qty = 10 } } } -- Bell of Dethmoora (level 60)
Q[7629] = { requires = { { 7630, "Arcanite" } }, start = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, finish = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, obj = { { kill = 14500, name = "Parchment Created", qty = 1, from = "J'eevee", zone = "Scholomance" }, { item = 18688, name = "Imp in a Jar", qty = 1 } } } -- Imp Delivery (level 60)
Q[7630] = { requires = { { 7626, "Bell of Dethmoora" } }, start = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, finish = { npc = "Gorzeeki Wildeyes", zone = "Burning Steppes", x = 12.4, y = 31.6 }, obj = { { item = 12360, name = "Arcanite Bar", qty = 3 } } } -- Arcanite (level 60)
Q[7631] = { requires = { { 7629, "Imp Delivery" } }, start = { npc = "Mor'zul Bloodbringer", zone = "Burning Steppes", x = 12.6, y = 31.6 }, finish = { npc = "Dreadsteed Spirit", zone = "Dire Maul" } } -- Dreadsteed of Xoroth (level 60)
Q[8419] = { starts = { { npc = "Demisette Cloyce", zone = "Stormwind City", x = 39.2, y = 85, faction = "Alliance", races = { 1 } }, { npc = "Briarthorn", zone = "Ironforge", x = 50.2, y = 6, faction = "Alliance" }, { npc = "Zevrost", zone = "Orgrimmar", x = 48.2, y = 45.6, faction = "Horde", races = { 2 } }, { npc = "Kaal Soulreaper", zone = "Undercity", x = 86, y = 15.6, faction = "Horde" } }, finish = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, obj = { { item = 14256, name = "Felcloth", qty = 1 } } } -- An Imp's Request (level 52)
Q[8420] = { start = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, finish = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, obj = { { item = 14256, name = "Felcloth", qty = 1, from = "Jadefire Rogue / Jadefire Trickster / Jadefire Betrayer", zone = "Felwood", x = 35.4, y = 66.8 } } } -- Hot and Itchy (level 52)
Q[8421] = { requiresOneOf = { { 8419, "An Imp's Request" } }, start = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, finish = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, obj = { { item = 20613, name = "Rotting Wood", qty = 10, from = "Irontree Wanderer / Irontree Stomper / Withered Protector", zone = "Felwood", x = 50.6, y = 18.2 }, { item = 20614, name = "Bloodvenom Essence", qty = 4, from = "Tainted Ooze", zone = "Felwood", x = 39.6, y = 54.4 } } } -- The Wrong Stuff (level 52)
Q[8422] = { start = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, finish = { npc = "Impsy", zone = "Felwood", x = 41.4, y = 44.8 }, obj = { { item = 20606, name = "Amber Voodoo Feather", qty = 2 }, { item = 20607, name = "Blue Voodoo Feather", qty = 2 }, { item = 20608, name = "Green Voodoo Feather", qty = 2 } } } -- Trolls of a Feather (level 52)
