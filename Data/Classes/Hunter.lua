-- Journal Assistant - Hunter class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.HUNTER = {
    { key = "hunt10nelf", level = 10, races = { "NightElf" },
      title = "Taming the Beast", reward = "Tame Beast, then Beast Training", spell = 1515,
      steps = { { id = 6071, alt = { 6072 }, name = "The Hunter's Path" }, q(6063, "Taming the Beast"), q(6101, "Taming the Beast"), q(6102, "Taming the Beast"), q(6103, "Training the Beast") },
      start = { npc = "Jocaste", zone = "Darnassus", note = "or Terenthis, Darkshore; then Dazalar in Dolanaar" }, zones = { "Darnassus" }, confidence = "forever-guide" },
    { key = "hunt10dwarf", level = 10, races = { "Dwarf" },
      title = "Taming the Beast", reward = "Tame Beast, then Beast Training", spell = 1515,
      steps = { { id = 6074, alt = { 6075 }, name = "The Hunter's Path" }, q(6064, "Taming the Beast"), q(6084, "Taming the Beast"), q(6085, "Taming the Beast"), q(6086, "Training the Beast") },
      start = { npc = "Olmin Burningbeard", zone = "Ironforge", note = "or Tristane Shadowstone, Dun Morogh; then Grif Wildheart in Kharanos" }, zones = { "Ironforge" }, confidence = "forever-guide" },
    { key = "hunt10tauren", level = 10, races = { "Tauren" },
      title = "Taming the Beast", reward = "Tame Beast, then Beast Training", spell = 1515,
      steps = { { id = 6065, alt = { 6066 }, name = "The Hunter's Path" }, q(6061, "Taming the Beast"), q(6087, "Taming the Beast"), q(6088, "Taming the Beast"), q(6089, "Training the Beast") },
      start = { npc = "Kary Thunderhorn", zone = "Thunder Bluff", note = "or Sian'dur, Orgrimmar; then Yaw Sharpmane in Bloodhoof Village" }, confidence = "forever-guide" },
    { key = "hunt10orc", level = 10, races = { "Orc", "Troll" },
      title = "Taming the Beast", reward = "Tame Beast, then Beast Training", spell = 1515,
      steps = { { id = 6068, alt = { 6069 }, name = "The Hunter's Path" }, q(6062, "Taming the Beast"), q(6083, "Taming the Beast"), q(6082, "Taming the Beast"), q(6081, "Training the Beast") },
      start = { npc = "Sian'dur", zone = "Orgrimmar", note = "or Kali Remik, Sen'jin Village; then Thotar in Razor Hill" }, confidence = "forever-guide" },
    { key = "hunt10sky", level = 10, races = { "Skyborne" },
      title = "Taming the Beast", reward = "Tame Beast", spell = 1515,
      steps = { q(94013, "Taming the Beast"), q(94978, "Taming the Beast"), q(94979, "Taming the Beast") },
      start = { npc = "Quel'ana Quickgale", note = "Valanaar, Zephras Isle" }, confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[6061] = { races = { 6 }, start = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 }, finish = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 } } -- Taming the Beast (level 10)
Q[6062] = { races = { 2, 8 }, start = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 }, finish = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 } } -- Taming the Beast (level 10)
Q[6063] = { races = { 4 }, start = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 }, finish = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 } } -- Taming the Beast (level 10)
Q[6064] = { races = { 3 }, start = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 }, finish = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 } } -- Taming the Beast (level 10)
Q[6065] = { races = { 6 }, start = { npc = "Kary Thunderhorn", zone = "Thunder Bluff", x = 58.2, y = 87.8 }, finish = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 } } -- The Hunter's Path (level 10)
Q[6066] = { races = { 6 }, start = { npc = "Sian'dur", zone = "Orgrimmar", x = 67.8, y = 17.8 }, finish = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 } } -- The Hunter's Path (level 10)
Q[6068] = { races = { 2, 5 }, start = { npc = "Sian'dur", zone = "Orgrimmar", x = 67.8, y = 17.8 }, finish = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 } } -- The Hunter's Path (level 10)
Q[6069] = { races = { 2, 8 }, start = { npc = "Kali Remik", zone = "Durotar", x = 56.2, y = 74.2 }, finish = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 } } -- The Hunter's Path (level 10)
Q[6071] = { races = { 4 }, start = { npc = "Jocaste", zone = "Darnassus", x = 40.2, y = 8.8 }, finish = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 } } -- The Hunter's Path (level 10)
Q[6072] = { races = { 4 }, start = { npc = "Terenthis", zone = "Darkshore", x = 39.2, y = 43.4 }, finish = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 } } -- The Hunter's Path (level 10)
Q[6074] = { races = { 3 }, start = { npc = "Olmin Burningbeard", zone = "Ironforge", x = 70.6, y = 83.8 }, finish = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 } } -- The Hunter's Path (level 10)
Q[6075] = { races = { 3 }, start = { npc = "Tristane Shadowstone", zone = "Dun Morogh", x = 30.6, y = 45.4 }, finish = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 } } -- The Hunter's Path (level 10)
Q[6081] = { races = { 2, 5, 8 }, start = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 }, finish = { npc = "Ormak Grimshot", zone = "Orgrimmar", x = 66.2, y = 18.2 } } -- Training the Beast (level 10)
Q[6082] = { races = { 2, 8 }, start = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 }, finish = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 } } -- Taming the Beast (level 10)
Q[6083] = { races = { 2, 8 }, start = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 }, finish = { npc = "Thotar", zone = "Durotar", x = 51.8, y = 43.4 } } -- Taming the Beast (level 10)
Q[6084] = { races = { 3 }, start = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 }, finish = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 } } -- Taming the Beast (level 10)
Q[6085] = { races = { 3 }, start = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 }, finish = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 } } -- Taming the Beast (level 10)
Q[6086] = { races = { 3 }, start = { npc = "Grif Wildheart", zone = "Dun Morogh", x = 45.8, y = 53 }, finish = { npc = "Belia Thundergranite", zone = "Ironforge", x = 70.8, y = 85.4 } } -- Training the Beast (level 10)
Q[6087] = { races = { 6 }, start = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 }, finish = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 } } -- Taming the Beast (level 10)
Q[6088] = { races = { 6 }, start = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 }, finish = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 } } -- Taming the Beast (level 10)
Q[6089] = { races = { 6 }, start = { npc = "Yaw Sharpmane", zone = "Mulgore", x = 46.8, y = 59.6 }, finish = { npc = "Holt Thunderhorn", zone = "Thunder Bluff", x = 57.4, y = 89.2 } } -- Training the Beast (level 10)
Q[6101] = { races = { 4 }, start = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 }, finish = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 } } -- Taming the Beast (level 10)
Q[6102] = { races = { 4 }, start = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 }, finish = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 } } -- Taming the Beast (level 10)
Q[6103] = { races = { 4 }, start = { npc = "Dazalar", zone = "Teldrassil", x = 56.6, y = 59.6 }, finish = { npc = "Jocaste", zone = "Darnassus", x = 40.2, y = 8.8 } } -- Training the Beast (level 10)
Q[94013] = { races = { 95 }, start = { npc = "Quel'ana Quickgale", zone = "Zephras Isle", x = 59.6, y = 72.6 }, finish = { npc = "Quel'ana Quickgale", zone = "Zephras Isle", x = 59.6, y = 72.6 } } -- Taming the Beast (level 10)
Q[94978] = { races = { 95 }, start = { npc = "Quel'ana Quickgale", zone = "Zephras Isle", x = 59.6, y = 72.6 }, finish = { npc = "Quel'ana Quickgale", zone = "Zephras Isle", x = 59.6, y = 72.6 } } -- Taming the Beast (level 10)
Q[94979] = { races = { 95 }, start = { npc = "Quel'ana Quickgale", zone = "Zephras Isle", x = 59.6, y = 72.6 }, finish = { npc = "Quel'ana Quickgale", zone = "Zephras Isle", x = 59.6, y = 72.6 } } -- Taming the Beast (level 10)
