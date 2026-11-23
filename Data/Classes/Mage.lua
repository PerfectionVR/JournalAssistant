-- Journal Assistant - Mage class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.MAGE = {
    { key = "mage10gnome", level = 10, faction = "Alliance", races = { "Gnome", "Dwarf" },
      title = "Mage-tastic Gizmonitor", reward = "Arcane Orb or Arcane Staff",
      steps = { q(1879, "Speak with Bink"), q(1880, "Mage-tastic Gizmonitor") },
      start = { npc = "Bink", zone = "Ironforge", note = "Mystic Ward" }, confidence = "forever-guide" },
    { key = "mage10human", level = 10, faction = "Alliance", races = { "Human", "NightElf" },
      title = "Mirror Lake", reward = "Ley Orb or Ley Staff",
      steps = { q(1860, "Speak with Jennea"), q(1861, "Mirror Lake") },
      start = { npc = "Jennea Cannon", zone = "Stormwind City", note = "Mage Quarter" },
      zones = { "Elwynn Forest" }, confidence = "forever-guide" },
    { key = "mage10sky", level = 10, races = { "Skyborne" },
      title = "Boughs in the Wind", reward = "Windbough Wand",
      steps = { q(93791, "Speak with Belann"), q(93797, "Boughs in the Wind") },
      start = { npc = "Belann Windwood", note = "Valanaar, Zephras Isle" }, confidence = "forever-guide" },
    { key = "mage15robe", level = 15, faction = "Alliance",
      title = "Manaweave Robe", reward = "Manaweave Robe",
      steps = { q(1919, "Report to Jennea"), q(1920, "Investigate the Blue Recluse"), q(1921, "Gathering Materials"), q(1941, "Manaweave Robe") },
      start = { npc = "Jennea Cannon", zone = "Stormwind City", note = "Mage Quarter" }, confidence = "forever-guide" },
    { key = "mage26robe", level = 26, faction = "Alliance",
      title = "Astral Knot Garment", reward = "Astral Knot Robe or Blouse",
      steps = { q(1939, "High Sorcerer Andromath"), q(1938, "Ur's Treatise on Shadow Magic"), q(1940, "Pristine Spider Silk"), q(1942, "Astral Knot Garment") },
      start = { npc = "High Sorcerer Andromath", zone = "Stormwind City", note = "Wizard's Sanctum" },
      zones = { "Redridge Mountains", "Duskwood" },
      note = "Book in the Tower of Ilgalar (Redridge); silk from Duskwood carrion recluses.", confidence = "forever-guide" },
    -- Journey to the Marsh > Mage's Wand: Unlocks / Series on wowhead.com/forever (2026-11-21)
    { key = "mage38wand", level = 30, optional = true,
      title = "Journey to the Marsh (Mage's Wand)", reward = "Icefury Wand",
      steps = { q(1947, "Journey to the Marsh"), q(1949, "Hidden Secrets"), q(1950, "Get the Scoop"),
                q(1951, "Rituals of Power"), q(1948, "Items of Power"), q(1952, "Mage's Wand") },
      start = { note = "from your capital's mage trainers; Tabetha is west of Theramore" },
      zones = { "Dustwallow Marsh", "Thousand Needles" }, confidence = "forever-guide" },
    { key = "mage10undead", level = 10, faction = "Horde", races = { "Scourge", "Troll" },
      title = "The Balnir Farmstead", reward = "Arcane Orb or Arcane Staff",
      steps = { q(1881, "Speak with Anastasia"), q(1882, "The Balnir Farmstead") },
      start = { npc = "Cain Firesong", zone = "Tirisfal Glades", note = "then Anastasia Hartwell, Undercity" }, confidence = "forever-guide" },
    { key = "mage10troll", level = 10, faction = "Horde", races = { "Orc" },
      title = "Ju-Ju Heaps", reward = "Ley Orb or Ley Staff",
      steps = { q(1883, "Speak with Un'thuwa"), q(1884, "Ju-Ju Heaps") },
      start = { npc = "Thurston Xane", zone = "Thunder Bluff", note = "then Un'thuwa, Sen'jin Village" }, confidence = "forever-guide" },
    { key = "mage15hrobe", level = 15, faction = "Horde",
      title = "Spellfire Robes", reward = "Lesser Spellfire Robes",
      steps = { q(1959, "Report to Anastasia"), q(1960, "Investigate the Alchemist Shop"), q(1961, "Gathering Materials"), q(1962, "Spellfire Robes") },
      start = { npc = "Anastasia Hartwell", zone = "Undercity" }, confidence = "forever-guide" },
    { key = "mage26hrobe", level = 26, faction = "Horde",
      title = "Nether-lace Garment", reward = "Nether-lace Robe or Tunic",
      steps = { q(1943, "Speak with Deino"), q(1944, "Waters of Xavian"), q(1945, "Laughing Sisters"), q(1946, "Nether-lace Garment") },
      start = { npc = "Deino", zone = "Orgrimmar", note = "Darkbriar Lodge" },
      zones = { "Ashenvale", "The Barrens" }, confidence = "forever-guide" },
}

-- Quest details generated from Wowhead Forever (see Data/Classes/Common.lua)
local Q = D.questInfo
Q[1860] = { races = { 1, 7, 95 }, start = { npc = "Zaldimar Wefhellt", zone = "Elwynn Forest", x = 43.2, y = 66.2 }, finish = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 } } -- Speak with Jennea (level 10)
Q[1861] = { races = { 1, 7, 95 }, start = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 }, finish = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 }, obj = { { item = 7206, name = "Mirror Lake Water Sample", qty = 1 } } } -- Mirror Lake (level 10)
Q[1879] = { races = { 1, 7 }, start = { npc = "Magis Sparkmantle", zone = "Dun Morogh", x = 47.4, y = 52 }, finish = { npc = "Bink", zone = "Ironforge", x = 27, y = 8.2 } } -- Speak with Bink (level 10)
Q[1880] = { races = { 1, 7 }, start = { npc = "Bink", zone = "Ironforge", x = 27, y = 8.2 }, finish = { npc = "Bink", zone = "Ironforge", x = 27, y = 8.2 }, obj = { { item = 7226, name = "Mage-tastic Gizmonitor", qty = 1, from = "Bink's Toolbox", zone = "Dun Morogh", x = 27.7, y = 36.5, mapID = 1426 } } } -- Mage-tastic Gizmonitor (level 10)
Q[1881] = { races = { 5, 8 }, start = { npc = "Cain Firesong", zone = "Tirisfal Glades", x = 61.8, y = 52.4 }, finish = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 } } -- Speak with Anastasia (level 10)
Q[1882] = { races = { 5, 8 }, start = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 }, finish = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 }, obj = { { item = 7227, name = "Balnir Snapdragons", qty = 1, from = "Balnir Snapdragons", zone = "Tirisfal Glades", x = 77.5, y = 62.1, mapID = 1420 } } } -- The Balnir Farmstead (level 10)
Q[1883] = { races = { 2, 5, 8 }, start = { npc = "Uthel'nay", zone = "Orgrimmar", x = 39, y = 86 }, finish = { npc = "Un'Thuwa", zone = "Durotar", x = 56.2, y = 75 } } -- Speak with Un'thuwa (level 10)
Q[1884] = { races = { 2, 5, 8 }, start = { npc = "Un'Thuwa", zone = "Durotar", x = 56.2, y = 75 }, finish = { npc = "Un'Thuwa", zone = "Durotar", x = 56.2, y = 75 }, obj = { { object = 102986, name = "Ju-Ju Heaps Destroyed", qty = 4, from = "Ju-Ju Heap", zone = "Durotar", x = 67.4, y = 82.7 } } } -- Ju-Ju Heaps (level 10)
Q[1919] = { races = { 1, 7, 95 }, start = { npc = "Zaldimar Wefhellt", zone = "Elwynn Forest", x = 43.2, y = 66.2 }, finish = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 } } -- Report to Jennea (level 15)
Q[1920] = { races = { 1, 7, 95 }, start = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 }, finish = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 }, obj = { { item = 7292, name = "Filled Containment Coffer", qty = 3, from = "Filled Containment Coffer", zone = "Undercity", x = 55.8, y = 71.3, mapID = 1458 }, { item = 7247, name = "Chest of Containment Coffers", qty = 1, from = "Chest of Containment Coffers", zone = "Stormwind City", x = 42.9, y = 81.9, mapID = 1453 }, { item = 7308, name = "Cantation of Manifestation", qty = 1, from = "Cantation of Manifestation", zone = "Stormwind City", x = 44, y = 82.4, mapID = 1453 } } } -- Investigate the Blue Recluse (level 16)
Q[1921] = { races = { 1, 7, 95 }, start = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 }, finish = { npc = "Wynne Larson", zone = "Stormwind City", x = 52, y = 83.6 }, obj = { { item = 2589, name = "Linen Cloth", qty = 10, from = "Old Town Thug / Forlorn Spirit / Target Dummy", zone = "Stormwind City", x = 73.8, y = 59.3 }, { item = 7249, name = "Charged Rift Gem", qty = 6, from = "Miners' League Crates", zone = "Loch Modan", x = 35.5, y = 23.7, mapID = 1432 } } } -- Gathering Materials (level 15)
Q[1938] = { races = { 1, 7, 95 }, start = { npc = "High Sorcerer Andromath", zone = "Stormwind City", x = 48.8, y = 87.6 }, finish = { npc = "High Sorcerer Andromath", zone = "Stormwind City", x = 48.8, y = 87.6 }, obj = { { item = 7266, name = "Ur's Treatise on Shadow Magic", qty = 1, from = "Ur's Treatise on Shadow Magic", zone = "Redridge Mountains", x = 76.5, y = 47.6, mapID = 1433 } } } -- Ur's Treatise on Shadow Magic (level 28)
Q[1939] = { races = { 1, 7, 95 }, start = { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86 }, finish = { npc = "High Sorcerer Andromath", zone = "Stormwind City", x = 48.8, y = 87.6 } } -- High Sorcerer Andromath (level 26)
Q[1940] = { races = { 1, 7, 95 }, start = { npc = "High Sorcerer Andromath", zone = "Stormwind City", x = 48.8, y = 87.6 }, finish = { npc = "Wynne Larson", zone = "Stormwind City", x = 52, y = 83.6 }, obj = { { item = 7267, name = "Pristine Spider Silk", qty = 8, from = "Black Widow Hatchling / Carrion Recluse", zone = "Duskwood", x = 32.6, y = 59.7 } } } -- Pristine Spider Silk (level 26)
Q[1941] = { requires = { { 1921, "Gathering Materials" } }, start = { npc = "Wynne Larson", zone = "Stormwind City", x = 52, y = 83.6 }, finish = { npc = "Wynne Larson", zone = "Stormwind City", x = 52, y = 83.6 } } -- Manaweave Robe (level 15)
Q[1942] = { requires = { { 1940, "Pristine Spider Silk" } }, start = { npc = "Wynne Larson", zone = "Stormwind City", x = 52, y = 83.6 }, finish = { npc = "Wynne Larson", zone = "Stormwind City", x = 52, y = 83.6 } } -- Astral Knot Garment (level 26)
Q[1943] = { races = { 2, 5, 8 }, start = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 }, finish = { npc = "Deino", zone = "Orgrimmar", x = 38.4, y = 85.8 } } -- Speak with Deino (level 26)
Q[1944] = { races = { 2, 5, 8 }, start = { npc = "Deino", zone = "Orgrimmar", x = 38.4, y = 85.8 }, finish = { npc = "Deino", zone = "Orgrimmar", x = 38.4, y = 85.8 }, obj = { { item = 7268, name = "Xavian Water Sample", qty = 1 } } } -- Waters of Xavian (level 26)
Q[1945] = { races = { 2, 5, 8 }, start = { npc = "Deino", zone = "Orgrimmar", x = 38.4, y = 85.8 }, finish = { npc = "Kil'hala", zone = "The Barrens", x = 52.2, y = 31.6 }, obj = { { item = 7270, name = "Laughing Sister's Hair", qty = 12, from = "Laughing Sister", zone = "Ashenvale", x = 60.6, y = 52.4 } } } -- Laughing Sisters (level 26)
Q[1946] = { requires = { { 1945, "Laughing Sisters" } }, start = { npc = "Kil'hala", zone = "The Barrens", x = 52.2, y = 31.6 }, finish = { npc = "Kil'hala", zone = "The Barrens", x = 52.2, y = 31.6 } } -- Nether-lace Garment (level 26)
Q[1947] = { starts = { { npc = "Jennea Cannon", zone = "Stormwind City", x = 49.4, y = 86, faction = "Alliance", races = { 1 } }, { npc = "Bink", zone = "Ironforge", x = 27, y = 8.2, faction = "Alliance" }, { npc = "Deino", zone = "Orgrimmar", x = 38.4, y = 85.8, faction = "Horde", races = { 2, 8 } }, { npc = "Ursyn Ghull", zone = "Thunder Bluff", x = 25.6, y = 14.6, faction = "Horde", races = { 6 } }, { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2, faction = "Horde" } }, finish = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 } } -- Journey to the Marsh (level 38)
Q[1948] = { requires = { { 1951, "Rituals of Power" } }, start = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 }, finish = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 }, obj = { { item = 1529, name = "Jade", qty = 1, from = "Bloodfen Raptor / Mirefin Puddlejumper / Mirefin Murloc", zone = "Dustwallow Marsh", x = 33.9, y = 45.6 }, { item = 7272, name = "Bolt Charged Bramble", qty = 1 }, { item = 7273, name = "Witherbark Totem Stick", qty = 10 } } } -- Items of Power (level 40)
Q[1949] = { requires = { { 1947, "Journey to the Marsh" } }, start = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 }, finish = { npc = "Magus Tirth", zone = "Thousand Needles", x = 78.2, y = 75.8 } } -- Hidden Secrets (level 38)
Q[1950] = { start = { npc = "Magus Tirth", zone = "Thousand Needles", x = 78.2, y = 75.8 }, finish = { npc = "Magus Tirth", zone = "Thousand Needles", x = 78.2, y = 75.8 } } -- Get the Scoop (level 30)
Q[1951] = { start = { npc = "Magus Tirth", zone = "Thousand Needles", x = 78.2, y = 75.8 }, finish = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 }, obj = { { item = 7274, name = "Rituals of Power", qty = 1 } } } -- Rituals of Power (level 40)
Q[1952] = { requires = { { 1948, "Items of Power" } }, start = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 }, finish = { npc = "Tabetha", zone = "Dustwallow Marsh", x = 46, y = 57 } } -- Mage's Wand (level 40)
Q[1959] = { races = { 2, 5, 8 }, start = { npc = "Cain Firesong", zone = "Tirisfal Glades", x = 61.8, y = 52.4 }, finish = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 } } -- Report to Anastasia (level 15)
Q[1960] = { races = { 2, 5, 8 }, start = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 }, finish = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 }, obj = { { item = 7292, name = "Filled Containment Coffer", qty = 3, from = "Filled Containment Coffer", zone = "Undercity", x = 55.8, y = 71.3, mapID = 1458 }, { item = 7247, name = "Chest of Containment Coffers", qty = 1, from = "Chest of Containment Coffers", zone = "Stormwind City", x = 42.9, y = 81.9, mapID = 1453 }, { item = 7308, name = "Cantation of Manifestation", qty = 1, from = "Cantation of Manifestation", zone = "Stormwind City", x = 44, y = 82.4, mapID = 1453 } } } -- Investigate the Alchemist Shop (level 16)
Q[1961] = { races = { 2, 5, 8 }, start = { npc = "Anastasia Hartwell", zone = "Undercity", x = 85, y = 10.2 }, finish = { npc = "Josef Gregorian", zone = "Undercity", x = 70.6, y = 30.4 }, obj = { { item = 2589, name = "Linen Cloth", qty = 10, from = "Scarlet Zealot / Scarlet Missionary", zone = "Undercity", x = 22.1, y = 18.5 }, { item = 7293, name = "Dalaran Mana Gem", qty = 6, from = "Dalaran Apprentice (13-14) / Dalaran Protector (14-15)", zone = "Silverpine Forest", x = 52.5, y = 64.8, mapID = 1421, areaMin = 13 } } } -- Gathering Materials (level 15)
Q[1962] = { requires = { { 1961, "Gathering Materials" } }, start = { npc = "Rhiannon Davis", zone = "Undercity", x = 70.2, y = 30.2 }, finish = { npc = "Josef Gregorian", zone = "Undercity", x = 70.6, y = 30.4 } } -- Spellfire Robes (level 15)
Q[93791] = { races = { 95 }, start = { npc = "Anathamaas Aetherwind", zone = "Zephras Isle", x = 65.8, y = 80.4 }, finish = { npc = "Belann Windwood", zone = "Zephras Isle", x = 62.8, y = 77.4 } } -- Speak with Belann (level 10)
Q[93797] = { races = { 95 }, start = { npc = "Belann Windwood", zone = "Zephras Isle", x = 62.8, y = 77.4 }, finish = { npc = "Belann Windwood", zone = "Zephras Isle", x = 62.8, y = 77.4 }, obj = { { item = 262668, name = "Wind-Infused Bough", qty = 1, from = "Wind-Infused Bough", zone = "Zephras Isle", x = 48.5, y = 67.7, mapID = 2521 } } } -- Boughs in the Wind (level 10)
