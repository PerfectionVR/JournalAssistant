-- Journal Assistant - Warrior class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.WARRIOR = {
    { key = "war10human", level = 10, faction = "Alliance", races = { "Human" },
      -- no completion spell: Defensive Stance comes before the follow-ups
      -- (1665 "Unlocks" 1666 > 1667 on wowhead.com/forever, checked 2026-11-21)
      title = "Defensive Stance (Bartleby)", reward = "Defensive Stance, Sunder Armor, Taunt, then a weapon (Dead-tooth Jack)",
      steps = { q(1638, "A Warrior's Training"), q(1639, "Bartleby the Drunk"), q(1640, "Beat Bartleby"), q(1665, "Bartleby's Mug"),
                q(1666, "Marshal Haggard"), q(1667, "Dead-tooth Jack") },
      start = { npc = "Harry Burlguard", zone = "Stormwind City", note = "Pig and Whistle tavern, Old Town" },
      confidence = "forever-guide" },
    { key = "war10dwarf", level = 10, faction = "Alliance", races = { "Dwarf", "Gnome" },
      title = "Defensive Stance (Vejrek)", reward = "Defensive Stance, then a one-hand weapon (Grey Iron Weapons)",
      steps = { q(1679, "Muren Stormpike"), q(1678, "Vejrek"), q(1680, "Tormus Deepforge"), q(1681, "Ironband's Compound"),
                q(1682, "Grey Iron Weapons") },
      start = { npc = "Muren Stormpike", zone = "Ironforge", note = "Hall of Arms, Military Ward" },
      zones = { "Dun Morogh" }, confidence = "forever-guide" },
    { key = "war10nelf", level = 10, faction = "Alliance", races = { "NightElf" },
      title = "Defensive Stance (Vorlus Vilehoof)", reward = "Defensive Stance, then a weapon (Weapons of Elunite)",
      steps = { q(1684, "Elanaria"), q(1683, "Vorlus Vilehoof"), q(1686, "The Shade of Elura"), q(1692, "Smith Mathiel"),
                q(1693, "Weapons of Elunite") },
      start = { npc = "Elanaria", zone = "Darnassus", note = "Warrior's Terrace" },
      zones = { "Teldrassil", "Darkshore" }, confidence = "forever-guide" },
    { key = "war10sky", level = 10, races = { "Skyborne" },
      title = "Defensive Stance (Skyborne)", reward = "Defensive Stance, Stormforged Protector", spell = 71,
      steps = { n("The Skybreaker Bulwark") },
      start = { npc = "your Warrior trainer", zone = nil, note = "Zephras Isle" },
      confidence = "unverified" },
    { key = "war10horde", level = 10, faction = "Horde", races = { "Orc", "Troll", "Tauren", "Scourge" },
      title = "Defensive Stance", reward = "Defensive Stance, Sunder Armor, Taunt", spell = 71,
      steps = { n("Ask your Warrior trainer (Path of Defense / Ulag the Cleaver)") },
      confidence = "unverified" },
    { key = "war20", level = 20, faction = "Alliance",
      title = "The Rethban Gauntlet (shield)", reward = "Shield",
      steps = { q(1698, "Yorus Barleybrew"), q(1699, "The Rethban Gauntlet"), q(1702, "The Shieldsmith") },
      start = { npc = "Yorus Barleybrew", zone = "Redridge Mountains", note = "Lakeshire Inn" },
      zones = { "Redridge Mountains", "Stormwind City" }, confidence = "forever-guide" },
    { key = "war28mail", level = 28, faction = "Alliance", optional = true,
      title = "Fire Hardened Mail", reward = "Fire Hardened Hauberk",
      after = "war20",
      -- objectives and drop sources: wowhead.com/forever/quest=1701, item=6838-6841
      -- (dropped-by lists) and the NPC pages' map data, checked 2026-11-20
      steps = { { id = 1701, name = "Fire Hardened Mail", objectives = {
          { item = 6838, name = "Scorched Spider Fang", qty = 50, from = "Cave Stalker / Leech Stalker (21-22)",
            zone = "Wetlands", x = 48.8, y = 61.0, mapID = 1437 },
          { item = 6839, name = "Charred Horn", qty = 12, from = "Fledgling Chimaera (25-27) / Young Chimaera (23-25)",
            zone = "Stonetalon Mountains", x = 31.8, y = 70.6, mapID = 1442 },
          { item = 6840, name = "Galvanized Horn", qty = 1, from = "Chimaera Matriarch (28)",
            zone = "Stonetalon Mountains", x = 33.3, y = 72.7, mapID = 1442 },
          { item = 6841, name = "Vial of Phlogiston", qty = 1, from = "Roogug (28 elite) inside Razorfen Kraul - bring a group",
            zone = "The Barrens", dungeon = "Razorfen Kraul", areaMin = 28 },
      } } },
      start = { npc = "Furen Longbeard", zone = "Stormwind City", note = "Dwarven District - pick up and turn in here" },
      zones = { "Wetlands", "Stonetalon Mountains", "The Barrens" }, confidence = "forever-guide" },
    -- 1701 "Unlocks" 1782 (wowhead.com/forever, checked 2026-11-21); like the race quests
    -- below it only requires Fire Hardened Mail, so it is its own chain
    { key = "war28furen", level = 28, faction = "Alliance", after = "war28mail", optional = true,
      title = "Furen's Armor", reward = "Fire Hardened armor piece",
      steps = { q(1782, "Furen's Armor") },
      start = { npc = "Furen Longbeard", zone = "Stormwind City" }, confidence = "forever-guide" },
    -- the three follow-ups below: race and prerequisite from wowhead.com/forever/quest=1700 / 1703 / 1704
    -- ("Race" in Quick Facts, "Requires: Fire Hardened Mail"), checked 2026-11-20
    { key = "war28coif", level = 28, faction = "Alliance", races = { "Human" }, after = "war28mail", optional = true,
      title = "Grimand's Armor", reward = "Fire Hardened Coif",
      steps = { q(1700, "Grimand Elmore"), q(1705, "Burning Blood"), q(1706, "Grimand's Armor") },
      start = { npc = "Grimand Elmore", zone = "Stormwind City", note = "Dwarven District weapon shop; materials in Duskwood (Roland's Doom)" },
      zones = { "Duskwood" }, confidence = "forever-guide" },
    { key = "war28mathiel", level = 28, faction = "Alliance", races = { "NightElf" }, after = "war28mail", optional = true,
      title = "Sunscorched Shells", reward = "Fire Hardened armor piece",
      steps = { q(1703, "Mathiel"), q(1710, "Sunscorched Shells"), q(1711, "Mathiel's Armor") },
      start = { npc = "Mathiel", zone = "Darnassus" },
      zones = { "Thousand Needles" }, confidence = "forever-guide" },
    { key = "war28klock", level = 28, faction = "Alliance", races = { "Dwarf", "Gnome" }, after = "war28mail", optional = true,
      title = "Iron Coral", reward = "Fire Hardened armor piece",
      steps = { q(1704, "Klockmort Spannerspan"), q(1708, "Iron Coral"), q(1709, "Klockmort's Creation") },
      start = { npc = "Klockmort Spannerspan", zone = "Ironforge" },
      zones = { "Wetlands" }, confidence = "forever-guide" },
    -- One chain on wowhead.com/forever (checked 2026-11-21): Series 1718 > 1719, 1719 "Unlocks"
    -- 1791, Series 1791 > 1712 > 1713, Cyclonian "Unlocks On Accept" 1714 (which "Requires In
    -- Progress" Cyclonian), 1713 "Unlocks" 1792. All require level 30. No completion spell:
    -- Berserker Stance (from The Affray) comes before the Whirlwind weapon steps.
    -- Essence of the Exile comes before Cyclonian here because it is finished first.
    { key = "war30berserk", level = 30,
      title = "Berserker Stance and Whirlwind weapon", reward = "Berserker Stance, Intercept, then a Whirlwind Axe, Sword or Warhammer",
      steps = { q(1718, "The Islander"), q(1719, "The Affray"), q(1791, "The Windwatcher"),
                { id = 1714, name = "Essence of the Exile", note = "Accept Cyclonian from Bath'rah first: this opens when you do." },
                q(1712, "Cyclonian"), q(1713, "The Summoning"), q(1792, "Whirlwind Weapon") },
      start = { note = "your Warrior trainer area in a capital, then Klannoc Macleod on Fray Island (south of Ratchet)" },
      area = { min = 30, name = "Fray Island gauntlet" }, confidence = "forever-guide",
      zones = { "The Barrens", "Alterac Mountains", "Arathi Highlands", "Stranglethorn Vale" },
      note = "The Affray: a short gauntlet of mobs, then Big Will. Whirlwind weapon: 8 Liferoot, 30 Bloodscalp Tusks, an Essence of the Exile (8 of each charm from the Exiles in Arathi, level 38-39), then summon and kill Cyclonian (level 40 recommended). Liferoot and tusks can be bought on the AH." },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[1638] = { start = { npc = "Lyria Du Lac", zone = "Elwynn Forest", x = 41, y = 65.8 }, finish = { npc = "Harry Burlguard", zone = "Stormwind City", x = 77, y = 53.2 } } -- A Warrior's Training (level 10)
Q[1639] = { start = { npc = "Harry Burlguard", zone = "Stormwind City", x = 77, y = 53.2 }, finish = { npc = "Bartleby", zone = "Stormwind City", x = 76.5, y = 52.6 } } -- Bartleby the Drunk (level 10)
Q[1640] = { start = { npc = "Bartleby", zone = "Stormwind City", x = 76.5, y = 52.6 }, finish = { npc = "Bartleby", zone = "Stormwind City", x = 76.5, y = 52.6 } } -- Beat Bartleby (level 10)
Q[1665] = { start = { npc = "Bartleby", zone = "Stormwind City", x = 76.5, y = 52.6 }, finish = { npc = "Harry Burlguard", zone = "Stormwind City", x = 77, y = 53.2 }, obj = { { item = 6781, name = "Bartleby's Mug", qty = 1 } } } -- Bartleby's Mug (level 10)
Q[1666] = { requires = { { 1665, "Bartleby's Mug" } }, start = { npc = "Harry Burlguard", zone = "Stormwind City", x = 77, y = 53.2 }, finish = { npc = "Marshal Haggard", zone = "Elwynn Forest", x = 84.6, y = 69.4 } } -- Marshal Haggard (level 10)
Q[1667] = { start = { npc = "Marshal Haggard", zone = "Elwynn Forest", x = 84.6, y = 69.4 }, finish = { npc = "Marshal Haggard", zone = "Elwynn Forest", x = 84.6, y = 69.4 }, obj = { { item = 6782, name = "Marshal Haggard's Badge", qty = 1, from = "Dead-tooth Jack's camp", zone = "Elwynn Forest", x = 89.2, y = 79 }, { item = 6783, name = "Dead-tooth's Key", qty = 1, from = "Dead-Tooth Jack (11)", zone = "Elwynn Forest", x = 89.2, y = 79, areaMin = 11 } } } -- Dead-tooth Jack (level 10)
Q[1678] = { start = { npc = "Muren Stormpike", zone = "Ironforge", x = 70.6, y = 90.4 }, finish = { npc = "Muren Stormpike", zone = "Ironforge", x = 70.6, y = 90.4 }, obj = { { item = 6799, name = "Vejrek's Head", qty = 1, from = "Vejrek", zone = "Dun Morogh", x = 27.6, y = 57.8 } } } -- Vejrek (level 11)
Q[1679] = { start = { npc = "Granis Swiftaxe", zone = "Dun Morogh", x = 47.2, y = 52.6 }, finish = { npc = "Muren Stormpike", zone = "Ironforge", x = 70.6, y = 90.4 } } -- Muren Stormpike (level 10)
Q[1680] = { start = { npc = "Muren Stormpike", zone = "Ironforge", x = 70.6, y = 90.4 }, finish = { npc = "Tormus Deepforge", zone = "Ironforge", x = 48.6, y = 43 } } -- Tormus Deepforge (level 11)
Q[1681] = { start = { npc = "Tormus Deepforge", zone = "Ironforge", x = 48.6, y = 43 }, finish = { npc = "Tormus Deepforge", zone = "Ironforge", x = 48.6, y = 43 }, obj = { { item = 6800, name = "Umbral Ore", qty = 1, from = "Ironband's Strongbox", zone = "Dun Morogh", x = 77.9, y = 62.2, mapID = 1426 } } } -- Ironband's Compound (level 11)
Q[1682] = { requires = { { 1681, "Ironband's Compound" } }, start = { npc = "Tormus Deepforge", zone = "Ironforge", x = 48.6, y = 43 }, finish = { npc = "Tormus Deepforge", zone = "Ironforge", x = 48.6, y = 43 } } -- Grey Iron Weapons (level 10)
Q[1683] = { start = { npc = "Elanaria", zone = "Darnassus", x = 57.4, y = 34.8 }, finish = { npc = "Elanaria", zone = "Darnassus", x = 57.4, y = 34.8 }, obj = { { item = 6805, name = "Horn of Vorlus", qty = 1, from = "Vorlus Vilehoof", zone = "Teldrassil", x = 47.2, y = 63.6 } } } -- Vorlus Vilehoof (level 10)
Q[1684] = { start = { npc = "Moon Priestess Amara", zone = "Teldrassil", x = 55.6, y = 58.4 }, finish = { npc = "Elanaria", zone = "Darnassus", x = 57.4, y = 34.8 } } -- Elanaria (level 10)
Q[1686] = { requires = { { 1683, "Vorlus Vilehoof" } }, start = { npc = "Elanaria", zone = "Darnassus", x = 57.4, y = 34.8 }, finish = { npc = "Elanaria", zone = "Darnassus", x = 57.4, y = 34.8 }, obj = { { item = 6808, name = "Elunite Ore", qty = 8, from = "Crate of Elunite", zone = "Darkshore", x = 32.5, y = 44.5, mapID = 1439 }, { item = 6809, name = "Elura's Medallion", qty = 1, from = "Shade of Elura", zone = "Darkshore", x = 31.6, y = 44.8 } } } -- The Shade of Elura (level 10)
Q[1692] = { start = { npc = "Elanaria", zone = "Darnassus", x = 57.4, y = 34.8 }, finish = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 }, obj = { { item = 6812, name = "Case of Elunite", qty = 1 } } } -- Smith Mathiel (level 10)
Q[1693] = { requires = { { 1692, "Smith Mathiel" } }, start = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 }, finish = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 } } -- Weapons of Elunite (level 10)
Q[1698] = { start = { npc = "Wu Shen", zone = "Stormwind City", x = 80.6, y = 59.6 }, finish = { npc = "Yorus Barleybrew", zone = "Redridge Mountains", x = 21.5, y = 44.7 } } -- Yorus Barleybrew (level 20)
Q[1699] = { start = { npc = "Yorus Barleybrew", zone = "Redridge Mountains", x = 21.5, y = 44.7 }, finish = { npc = "Yorus Barleybrew", zone = "Redridge Mountains", x = 21.5, y = 44.7 } } -- The Rethban Gauntlet (level 22)
Q[1700] = { races = { 1 }, requires = { { 1701, "Fire Hardened Mail" } }, start = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, finish = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 }, obj = { { item = 6926, name = "Furen's Notes", qty = 1 } } } -- Grimand Elmore (level 28)
Q[1701] = { start = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, finish = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, obj = { { item = 6838, name = "Scorched Spider Fang", qty = 50, from = "Leech Stalker / Cave Stalker", zone = "Wetlands", x = 51.5, y = 62.8 }, { item = 6839, name = "Charred Horn", qty = 12, from = "Fledgling Chimaera / Young Chimaera", zone = "Stonetalon Mountains", x = 33.9, y = 71 }, { item = 6840, name = "Galvanized Horn", qty = 1, from = "Chimaera Matriarch", zone = "Stonetalon Mountains", x = 34.7, y = 72 }, { item = 6841, name = "Vial of Phlogiston", qty = 1, from = "Roogug (28)", zone = "Razorfen Kraul", areaMin = 28 } } } -- Fire Hardened Mail (level 28)
Q[1702] = { requires = { { 1699, "The Rethban Gauntlet" } }, start = { npc = "Yorus Barleybrew", zone = "Redridge Mountains", x = 21.5, y = 44.7 }, finish = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, obj = { { item = 6843, name = "Cask of Scalder", qty = 1 } } } -- The Shieldsmith (level 22)
Q[1703] = { races = { 4 }, requires = { { 1701, "Fire Hardened Mail" } }, start = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, finish = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 }, obj = { { item = 6926, name = "Furen's Notes", qty = 1 } } } -- Mathiel (level 28)
Q[1704] = { races = { 3, 7 }, requires = { { 1701, "Fire Hardened Mail" } }, start = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, finish = { npc = "Klockmort Spannerspan", zone = "Ironforge", x = 68.2, y = 46.4 }, obj = { { item = 6926, name = "Furen's Notes", qty = 1 } } } -- Klockmort Spannerspan (level 28)
Q[1705] = { start = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 }, finish = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 }, obj = { { item = 6844, name = "Burning Blood", qty = 20, from = "Nightbane Worgen (26-27) / Nightbane Dark Runner (28-29)", zone = "Duskwood", x = 62.5, y = 40.6, mapID = 1431, areaMin = 26 }, { item = 6845, name = "Burning Rock", qty = 1, from = "Gutspill (32)", zone = "Duskwood", x = 73.6, y = 75.4, mapID = 1431, areaMin = 32 } } } -- Burning Blood (level 28)
Q[1706] = { requires = { { 1705, "Burning Blood" } }, start = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 }, finish = { npc = "Grimand Elmore", zone = "Stormwind City", x = 59.6, y = 34 } } -- Grimand's Armor (level 30)
Q[1708] = { start = { npc = "Klockmort Spannerspan", zone = "Ironforge", x = 68.2, y = 46.4 }, finish = { npc = "Klockmort Spannerspan", zone = "Ironforge", x = 68.2, y = 46.4 }, obj = { { item = 6848, name = "Searing Coral", qty = 20, from = "Iron Coral", zone = "Wetlands", x = 9.2, y = 69.3, mapID = 1437 } } } -- Iron Coral (level 29)
Q[1709] = { requires = { { 1708, "Iron Coral" } }, start = { npc = "Klockmort Spannerspan", zone = "Ironforge", x = 68.2, y = 46.4 }, finish = { npc = "Klockmort Spannerspan", zone = "Ironforge", x = 68.2, y = 46.4 } } -- Klockmort's Creation (level 30)
Q[1710] = { start = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 }, finish = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 }, obj = { { item = 6849, name = "Sunscorched Shell", qty = 20, from = "Sunscorched Shell", zone = "Thousand Needles", x = 12.8, y = 37.6, mapID = 1441 } } } -- Sunscorched Shells (level 30)
Q[1711] = { requires = { { 1710, "Sunscorched Shells" } }, start = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 }, finish = { npc = "Mathiel", zone = "Darnassus", x = 59.2, y = 45.4 } } -- Mathiel's Armor (level 30)
Q[1712] = { start = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 3357, name = "Liferoot", qty = 8, from = "Solid Chest / Alliance Chest / Thanthaldis Snowgleam", zone = "Alterac Mountains", x = 59.9, y = 43.4 }, { item = 3901, name = "Bloodscalp Tusk", qty = 30, from = "Bloodscalp Scavenger (33-34) / Bloodscalp Warrior (33-34)", area = 33, x = 31.9, y = 13, mapID = 1434, areaMin = 33 }, { item = 6851, name = "Essence of the Exile", qty = 1, from = "Bath'rah's Cauldron (quest Essence of the Exile)", zone = "Alterac Mountains", x = 79.3, y = 66.7 } } } -- Cyclonian (level 40)
Q[1713] = { start = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, obj = { { item = 6894, name = "Whirlwind Heart", qty = 1, from = "Cyclonian", zone = "Alterac Mountains", x = 80.6, y = 62 } } } -- The Summoning (level 40)
Q[1714] = { requiresActive = { { 1712, "Cyclonian" } }, start = { npc = "Bath'rah's Cauldron", zone = "Alterac Mountains", x = 79.3, y = 66.7 }, finish = { npc = "Bath'rah's Cauldron", zone = "Alterac Mountains", x = 79.3, y = 66.7 }, obj = { { item = 4480, name = "Thundering Charm", qty = 8, from = "Thundering Exile (38-39)", area = 45, x = 51.6, y = 51.1, mapID = 1417, areaMin = 38 }, { item = 4479, name = "Burning Charm", qty = 8, from = "Burning Exile (38-39)", area = 45, x = 25.4, y = 30.7, mapID = 1417, areaMin = 38 }, { item = 4481, name = "Cresting Charm", qty = 8, from = "Cresting Exile (38-39)", area = 45, x = 66.7, y = 30.1, mapID = 1417, areaMin = 38 } } } -- Essence of the Exile (level 37)
Q[1718] = { starts = { { npc = "Wu Shen", zone = "Stormwind City", x = 80.6, y = 59.6, faction = "Alliance" }, { npc = "Kelv Sternhammer", zone = "Ironforge", x = 70, y = 90.6, faction = "Alliance" }, { npc = "Sorek", zone = "Orgrimmar", x = 80.2, y = 32.4, faction = "Horde" }, { npc = "Torm Ragetotem", zone = "Thunder Bluff", x = 57.6, y = 87.2, faction = "Horde" }, { npc = "Baltus Fowler", zone = "Undercity", x = 47.2, y = 17, faction = "Horde" } }, finish = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 } } -- The Islander (level 30)
Q[1719] = { start = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 }, finish = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 }, obj = { { kill = 6238, name = "Big Will", qty = 1, zone = "The Barrens", x = 68.6, y = 48.6 } } } -- The Affray (level 30)
Q[1782] = { requires = { { 1701, "Fire Hardened Mail" } }, start = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 }, finish = { npc = "Furen Longbeard", zone = "Stormwind City", x = 64.6, y = 37.4 } } -- Furen's Armor (level 28)
Q[1791] = { requires = { { 1719, "The Affray" } }, start = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 } } -- The Windwatcher (level 30)
Q[1792] = { requires = { { 1713, "The Summoning" } }, start = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 }, finish = { npc = "Bath'rah the Windwatcher", zone = "Alterac Mountains", x = 80.4, y = 66.8 } } -- Whirlwind Weapon (level 40)
