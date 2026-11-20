-- Journal Assistant - Rogue class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.ROGUE = {
    { key = "rog16lock", level = 16, faction = "Alliance",
      title = "Alther's Mill (lockpicking)", reward = "Certificate of Thievery",
      steps = { q(2281, "Redridge Rendezvous"), q(2282, "Alther's Mill") },
      start = { npc = "Renzik \"The Shiv\"", zone = "Stormwind City" }, zones = { "Redridge Mountains" }, confidence = "forever-guide" },
    { key = "rog20poison", level = 20, faction = "Alliance",
      title = "Poisons (Klaven's Tower)", reward = "Poisons, Recipe: Thistle Tea", spell = 2842,
      steps = { q(2360, "Mathias and the Defias"), q(2359, "Klaven's Tower") },
      start = { npc = "Master Mathias Shaw", zone = "Stormwind City" }, zones = { "Westfall" },
      note = "Optional: The Touch of Zanzil (Doc Mixilpixil, Stormwind Barracks cellar).", confidence = "forever-guide" },
    { key = "rog16hlock", level = 16, faction = "Horde",
      title = "Plundering the Plunderers", reward = "Thistle Tea",
      steps = { q(2382, "Wrenix of Ratchet"), q(2381, "Plundering the Plunderers") },
      start = { npc = "Wrenix the Wretched", zone = "The Barrens", note = "Ratchet" }, confidence = "forever-guide" },
    { key = "rog20hpoison", level = 20, faction = "Horde",
      title = "Poisons (Hinott's Assistance)", reward = "Poisons", spell = 2842,
      steps = { q(2460, "The Shattered Salute"), q(2458, "Deep Cover"), q(2478, "Mission: Possible But Not Probable"), q(2479, "Hinott's Assistance"), q(2480, "Hinott's Assistance") },
      start = { npc = "Shenthul", zone = "Orgrimmar", note = "Cleft of Shadow" }, zones = { "The Barrens", "Hillsbrad Foothills" }, confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[2281] = { start = { npc = "Renzik \"The Shiv\"", zone = "Stormwind City", x = 78.4, y = 71 }, finish = { npc = "Lucius", zone = "Redridge Mountains", x = 28.2, y = 52.2 } } -- Redridge Rendezvous (level 16)
Q[2282] = { start = { npc = "Lucius", zone = "Redridge Mountains", x = 28.2, y = 52.2 }, finish = { npc = "Lucius", zone = "Redridge Mountains", x = 28.2, y = 52.2 }, obj = { { item = 7871, name = "Token of Thievery", qty = 1, from = "Lucius's Lockbox", zone = "Redridge Mountains", x = 48.5, y = 44.7, mapID = 1433 } } } -- Alther's Mill (level 20)
Q[2359] = { start = { npc = "Agent Kearnen", zone = "Westfall", x = 68.4, y = 70 }, finish = { npc = "Master Mathias Shaw", zone = "Stormwind City", x = 78.4, y = 70.6 }, obj = { { item = 7908, name = "Klaven Mortwake's Journal", qty = 1, from = "Klaven Mortwake / Duskwood Chest", zone = "Westfall", x = 70.4, y = 74.2 }, { item = 7923, name = "Defias Tower Key", qty = 1, from = "Malformed Defias Drone (23)", zone = "Westfall", x = 70.1, y = 73.6, mapID = 1436, areaMin = 23 } } } -- Klaven's Tower (level 24)
Q[2360] = { start = { npc = "Master Mathias Shaw", zone = "Stormwind City", x = 78.4, y = 70.6 }, finish = { npc = "Agent Kearnen", zone = "Westfall", x = 68.4, y = 70 } } -- Mathias and the Defias (level 20)
Q[2381] = { start = { npc = "Wrenix the Wretched", zone = "The Barrens", x = 63, y = 36.4 }, finish = { npc = "Wrenix the Wretched", zone = "The Barrens", x = 63, y = 36.4 }, obj = { { item = 7968, name = "Southsea Treasure", qty = 1, from = "Polly", zone = "The Barrens", x = 64.8, y = 45.4 } } } -- Plundering the Plunderers (level 18)
Q[2382] = { start = { npc = "Zando'zan", zone = "Orgrimmar", x = 42.8, y = 53 }, finish = { npc = "Wrenix the Wretched", zone = "The Barrens", x = 63, y = 36.4 } } -- Wrenix of Ratchet (level 16)
Q[2458] = { start = { npc = "Shenthul", zone = "Orgrimmar", x = 43, y = 53.4 }, finish = { npc = "Taskmaster Fizzule", zone = "The Barrens", x = 55.4, y = 5.6 } } -- Deep Cover (level 20)
Q[2460] = { start = { npc = "Shenthul", zone = "Orgrimmar", x = 43, y = 53.4 }, finish = { npc = "Shenthul", zone = "Orgrimmar", x = 43, y = 53.4 } } -- The Shattered Salute (level 20)
Q[2478] = { requires = { { 2458, "Deep Cover" } }, start = { npc = "Taskmaster Fizzule", zone = "The Barrens", x = 55.4, y = 5.6 }, finish = { npc = "Shenthul", zone = "Orgrimmar", x = 43, y = 53.4 }, obj = { { kill = 7310, name = "Mutated Venture Co. Drone", qty = 2, zone = "The Barrens", x = 54.8, y = 5.8 }, { kill = 7307, name = "Venture Co. Lookout", qty = 2, zone = "The Barrens", x = 54.6, y = 5.6 }, { kill = 7308, name = "Venture Co. Patroller", qty = 2, zone = "The Barrens", x = 54.6, y = 5.6 }, { item = 8074, name = "Gallywix's Head", qty = 1, from = "Grand Foreman Puzik Gallywix", zone = "The Barrens", x = 54.8, y = 5.6 }, { item = 8072, name = "Silixiz's Tower Key", qty = 1, from = "Foreman Silixiz (22)", zone = "The Barrens", x = 55, y = 6.7, mapID = 1413, areaMin = 22 }, { item = 8073, name = "Cache of Zanzil's Altered Mixture", qty = 1, from = "Taskmaster Fizzule / Gallywix's Lockbox", zone = "The Barrens", x = 55.4, y = 5.6 } } } -- Mission: Possible But Not Probable (level 24)
Q[2479] = { start = { npc = "Shenthul", zone = "Orgrimmar", x = 43, y = 53.4 }, finish = { npc = "Serge Hinott", zone = "Hillsbrad Foothills", x = 61.6, y = 19.2 }, obj = { { item = 8087, name = "Sample of Zanzil's Altered Mixture", qty = 1 } } } -- Hinott's Assistance (level 26)
Q[2480] = { start = { npc = "Serge Hinott", zone = "Hillsbrad Foothills", x = 61.6, y = 19.2 }, finish = { npc = "Serge Hinott", zone = "Hillsbrad Foothills", x = 61.6, y = 19.2 } } -- Hinott's Assistance (level 20)
