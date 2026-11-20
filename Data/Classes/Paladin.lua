-- Journal Assistant - Paladin class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.PALADIN = {
    { key = "pal12", level = 12, faction = "Alliance",
      title = "Redemption (The Tome of Divinity)", reward = "Redemption", spell = 7328,
      steps = { n("The Tome of Divinity") }, start = { zone = "Stormwind City", note = "Cathedral of Light / your paladin trainer" },
      confidence = "unverified" },
    { key = "pal20", level = 20, faction = "Alliance",
      title = "Verigan's Fist", reward = "Verigan's Fist (two-hand mace)",
      steps = { q(1793, "The Tome of Valor"), n("The Test of Righteousness") },
      start = { zone = "Stormwind City", note = "Cathedral of Light" }, confidence = "forever-guide" },
    { key = "pal12h", level = 12, faction = "Horde",
      title = "Redemption (A Lesson in Divinity)", reward = "Redemption", spell = 7328,
      steps = { n("A Lesson in Divinity") }, confidence = "unverified" },
    { key = "pal22h", level = 22, faction = "Horde",
      title = "The Moonsilver Blade", reward = "Moonsilver Blade",
      steps = { q(91858, "Diplomatic Incident"), q(91859, "A Curious Pair"), q(91860, "A Grim Fate"), q(91861, "Into Fenris Keep"),
                q(91862, "Lumina Windsinger"), q(96204, "The Windshaper's Wrath"), q(95034, "The Debt"), q(95036, "A Moon-Kissed Blade"),
                q(95111, "An Underrated Talent"), q(95125, "Ott's Masterwork"), q(95126, "The Moonsilver Blade") },
      start = { npc = "Trevan Rol", zone = "Silverpine Forest", note = "The Sepulcher" }, confidence = "forever-guide" },
    { key = "pal60", level = 60, faction = "Alliance",
      title = "Summon Charger (epic mount)", reward = "Summon Charger", spell = 23214,
      steps = { n("Ask your Paladin trainer") }, confidence = "unverified" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[1793] = { start = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 }, finish = { npc = "Duthorian Rall", zone = "Stormwind City", x = 50.6, y = 47.4 } } -- The Tome of Valor (level 20)
Q[91858] = { races = { 5 }, start = { npc = "Danitha Morr", zone = "Tirisfal Glades", x = 22, y = 44.6 }, finish = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 } } -- Diplomatic Incident (level 22)
Q[91859] = { races = { 5 }, start = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, finish = { npc = "Deathguard Baldren", zone = "Silverpine Forest", x = 45.6, y = 41.8 } } -- A Curious Pair (level 22)
Q[91860] = { races = { 5 }, start = { npc = "Deathguard Baldren", zone = "Silverpine Forest", x = 45.6, y = 41.8 }, finish = { npc = "Charred Remains", zone = "Silverpine Forest", x = 65, y = 34.2 } } -- A Grim Fate (level 22)
Q[91861] = { races = { 5 }, start = { npc = "Charred Remains", zone = "Silverpine Forest", x = 65, y = 34.2 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 } } -- Into Fenris Keep (level 22)
Q[91862] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 }, obj = { { item = 267412, name = "Fenris Isle Key", qty = 1, from = "Rot Hide Bruiser / Rot Hide Savage / Raging Rot Hide", zone = "Silverpine Forest", x = 67, y = 24.4 } } } -- Lumina Windsinger (level 22)
Q[95034] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 }, obj = { { kill = 259620, name = "Speak with Lumina Windsinger", qty = 1, from = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 } } } -- The Debt (level 24)
Q[95036] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 }, finish = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, obj = { { item = 267454, name = "Trevan's Weapon Notes", qty = 1 }, { item = 6994, name = "Whitestone Oak Lumber", qty = 1, from = "Goblin Woodcarver (18-19)", zone = "The Deadmines", areaMin = 18 }, { item = 267361, name = "Enchanted Silver Ingot", qty = 1 }, { item = 272448, name = "Purified Kor Gem", qty = 1 } } } -- A Moon-Kissed Blade (level 25)
Q[95111] = { races = { 5 }, start = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, finish = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, obj = { { item = 268192, name = "Bundle of Blacksmithing Materials", qty = 1 } } } -- An Underrated Talent (level 25)
Q[95125] = { races = { 5 }, start = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, finish = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, obj = { { kill = 259966, name = "Watch Ott craft the blade", qty = 1 } } } -- Ott's Masterwork (level 25)
Q[95126] = { races = { 5 }, start = { npc = "Ott", zone = "Hillsbrad Foothills", x = 60.4, y = 26 }, finish = { npc = "Trevan Rol", zone = "Silverpine Forest", x = 43.4, y = 41 }, obj = { { item = 268359, name = "Ott's Masterwork", qty = 1 } } } -- The Moonsilver Blade (level 25)
Q[96204] = { races = { 5 }, start = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 65.7, y = 27.4 }, finish = { npc = "Lumina Windsinger", zone = "Silverpine Forest", x = 43.2, y = 41 } } -- The Windshaper's Wrath (level 22)
