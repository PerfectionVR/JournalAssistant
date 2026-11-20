-- Journal Assistant - Blacksmithing recipe sources verified on Wowhead (WoW: Forever)
--
-- GENERATED 2026-11-20 from wowhead.com/forever spell, NPC and item pages:
--   req   = "Requires <Profession> (N)" on the spell page
--   npcs  = the spell's "Taught by" tab; zone, x, y, uiMapID from each NPC page's map
--   items = recipe items that teach it, with "Sold by" / "Dropped by" from the item page
-- Nothing here is guessed. Entries: { npcID, name, zone, faction (A/H/AH), x, y, uiMapID, areaID }
-- (zone is nil when only the area ID is known; the addon asks the game via C_Map.GetAreaInfo)

local _, ns = ...
local D = ns.Data

D.recipeTeachers["arcanite skeleton key"] = { spell = 19669, prof = "BLACKSMITHING", req = 250,
    npcs = {
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
    },
}
D.recipeTeachers["big black mace"] = { spell = 10001, prof = "BLACKSMITHING", req = 205,
    npcs = {
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
    },
}
D.recipeTeachers["bold dirk"] = { spell = 1252365, prof = "BLACKSMITHING", req = 270,
    items = {
        { item = 251468, name = "Plans: Bold Dirk",
          soldBy = {
            { 266901, "Pexmit", "Mount Hyjal", "AH", 46.8, 80.4, 2482, 616 },
          },
        },
    },
}
D.recipeTeachers["bronze warhammer"] = { spell = 9985, prof = "BLACKSMITHING", req = 100,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
    },
}
D.recipeTeachers["copper chain belt"] = { spell = 2661, prof = "BLACKSMITHING", req = 30,
    npcs = {
        { 251913, "Aedi Thriceforged", "Zephras Isle", "AH", 44.8, 44.4, 2521, 16593 },
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 259250, "Alphonse Dumas", "Riverglades", "AH", 64.4, 82, 2548, 16591 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4605, "Basil Frye", "Undercity", "H", 59.2, 29.4, 1458, 1497 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 957, "Dane Lindgren", "Stormwind City", "A", 64, 37.2, 1453, 1519 },
        { 6299, "Delfrum Flintbeard", "Darkshore", "A", 38.2, 41, 1439, 148 },
        { 3174, "Dwukk", "Durotar", "H", 52, 40.6, 1411, 14 },
        { 5513, "Gelman Stonehand", "Stormwind City", "A", 59, 37.8, 1453, 1519 },
        { 10277, "Groum Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3557, "Guillaume Sorouy", "Silverpine Forest", "H", 43, 40.4, 1421, 130 },
        { 256658, "Gur'dok", "Riverglades", "H", 60, 46.2, 2548, 16591 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 514, "Smith Argus", "Elwynn Forest", "A", 41.6, 65.4, 1429, 12 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 10278, "Thrag Stonehoof", "Thunder Bluff", "H", 39, 57.8, 1456, 1638 },
        { 1241, "Tognus Flintfire", "Dun Morogh", "A", 45.2, 52, 1426, 1 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
        { 10266, "Ug'thok", "Orgrimmar", "H", 80.4, 23.4, 1454, 1637 },
    },
}
D.recipeTeachers["dense weightstone"] = { spell = 16640, prof = "BLACKSMITHING", req = 225,
    npcs = {
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
    },
}
D.recipeTeachers["ebon shiv"] = { spell = 10013, prof = "BLACKSMITHING", req = 255,
    items = {
        { item = 8030, name = "Plans: Ebon Shiv",
          soldBy = {
            { 11278, "Magnus Frostwake", "Western Plaguelands", "AH", 68, 77.4, 1422, 28 },
          },
        },
    },
}
D.recipeTeachers["golden scale bracers"] = { spell = 7223, prof = "BLACKSMITHING", req = 160,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
    },
}
D.recipeTeachers["green iron bracers"] = { spell = 3501, prof = "BLACKSMITHING", req = 140,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
    },
}
D.recipeTeachers["green iron leggings"] = { spell = 3506, prof = "BLACKSMITHING", req = 130,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
    },
}
D.recipeTeachers["heavy mithril boots"] = { spell = 9968, prof = "BLACKSMITHING", req = 210,
    npcs = {
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
    },
}
D.recipeTeachers["heavy mithril breastplate"] = { spell = 9959, prof = "BLACKSMITHING", req = 205,
    npcs = {
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
    },
}
D.recipeTeachers["heavy mithril gauntlet"] = { spell = 9928, prof = "BLACKSMITHING", req = 180,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
    },
}
D.recipeTeachers["heavy sharpening stone"] = { spell = 2674, prof = "BLACKSMITHING", req = 100,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
    },
}
D.recipeTeachers["iron buckle"] = { spell = 8768, prof = "BLACKSMITHING", req = 125,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
    },
}
D.recipeTeachers["mithril coif"] = { spell = 9961, prof = "BLACKSMITHING", req = 205,
    npcs = {
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
    },
}
D.recipeTeachers["mithril plate pants"] = { spell = 9931, prof = "BLACKSMITHING", req = 185,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
    },
}
D.recipeTeachers["ornate thorium handaxe"] = { spell = 16969, prof = "BLACKSMITHING", req = 275,
    items = {
        { item = 12819, name = "Plans: Ornate Thorium Handaxe",
          soldBy = {
            { 11278, "Magnus Frostwake", "Western Plaguelands", "AH", 68, 77.4, 1422, 28 },
          },
        },
    },
}
D.recipeTeachers["patterned bronze bracers"] = { spell = 2672, prof = "BLACKSMITHING", req = 95,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
    },
}
D.recipeTeachers["rough bronze leggings"] = { spell = 2668, prof = "BLACKSMITHING", req = 80,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
    },
}
D.recipeTeachers["rough grinding stone"] = { spell = 3320, prof = "BLACKSMITHING", req = 25,
    npcs = {
        { 251913, "Aedi Thriceforged", "Zephras Isle", "AH", 44.8, 44.4, 2521, 16593 },
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 259250, "Alphonse Dumas", "Riverglades", "AH", 64.4, 82, 2548, 16591 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4605, "Basil Frye", "Undercity", "H", 59.2, 29.4, 1458, 1497 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 957, "Dane Lindgren", "Stormwind City", "A", 64, 37.2, 1453, 1519 },
        { 6299, "Delfrum Flintbeard", "Darkshore", "A", 38.2, 41, 1439, 148 },
        { 3174, "Dwukk", "Durotar", "H", 52, 40.6, 1411, 14 },
        { 5513, "Gelman Stonehand", "Stormwind City", "A", 59, 37.8, 1453, 1519 },
        { 10277, "Groum Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3557, "Guillaume Sorouy", "Silverpine Forest", "H", 43, 40.4, 1421, 130 },
        { 256658, "Gur'dok", "Riverglades", "H", 60, 46.2, 2548, 16591 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 514, "Smith Argus", "Elwynn Forest", "A", 41.6, 65.4, 1429, 12 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 10278, "Thrag Stonehoof", "Thunder Bluff", "H", 39, 57.8, 1456, 1638 },
        { 1241, "Tognus Flintfire", "Dun Morogh", "A", 45.2, 52, 1426, 1 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
        { 10266, "Ug'thok", "Orgrimmar", "H", 80.4, 23.4, 1454, 1637 },
    },
}
D.recipeTeachers["runed copper belt"] = { spell = 2666, prof = "BLACKSMITHING", req = 45,
    npcs = {
        { 251913, "Aedi Thriceforged", "Zephras Isle", "AH", 44.8, 44.4, 2521, 16593 },
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 259250, "Alphonse Dumas", "Riverglades", "AH", 64.4, 82, 2548, 16591 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4605, "Basil Frye", "Undercity", "H", 59.2, 29.4, 1458, 1497 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 957, "Dane Lindgren", "Stormwind City", "A", 64, 37.2, 1453, 1519 },
        { 6299, "Delfrum Flintbeard", "Darkshore", "A", 38.2, 41, 1439, 148 },
        { 3174, "Dwukk", "Durotar", "H", 52, 40.6, 1411, 14 },
        { 5513, "Gelman Stonehand", "Stormwind City", "A", 59, 37.8, 1453, 1519 },
        { 10277, "Groum Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3557, "Guillaume Sorouy", "Silverpine Forest", "H", 43, 40.4, 1421, 130 },
        { 256658, "Gur'dok", "Riverglades", "H", 60, 46.2, 2548, 16591 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 514, "Smith Argus", "Elwynn Forest", "A", 41.6, 65.4, 1429, 12 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 10278, "Thrag Stonehoof", "Thunder Bluff", "H", 39, 57.8, 1456, 1638 },
        { 1241, "Tognus Flintfire", "Dun Morogh", "A", 45.2, 52, 1426, 1 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
        { 10266, "Ug'thok", "Orgrimmar", "H", 80.4, 23.4, 1454, 1637 },
    },
}
D.recipeTeachers["silver skeleton key"] = { spell = 19666, prof = "BLACKSMITHING", req = 75,
    npcs = {
        { 28694, "Alard Schmied", "Alterac Mountains", "A", 19.4, 63.2, 1416, 36 },
        { 276067, "Angus Hammerhand", "Tirisfal Glades", "H", 21.2, 45.8, 1420, 85 },
        { 4258, "Bengus Deepforge", "Ironforge", "A", 51.4, 42.2, 1455, 1537 },
        { 2836, "Brikk Keencraft", "Stranglethorn Vale", "A", 29, 75.4, 1434, 33 },
        { 3136, "Clarise Gnarltree", "Duskwood", "A", 73.8, 48.6, 1431, 10 },
        { 252479, "Daeann Steelwind", "Zephras Isle", "AH", 65.4, 80.2, 2521, 16593 },
        { 4596, "James Van Brunt", "Undercity", "H", 61.2, 29.2, 1458, 1497 },
        { 2998, "Karn Stonehoof", "Thunder Bluff", "H", 38.8, 54, 1456, 1638 },
        { 10276, "Rotgath Stonebeard", "Ironforge", "A", 51.2, 42.4, 1455, 1537 },
        { 3355, "Saru Steelfury", "Orgrimmar", "H", 82.2, 23, 1454, 1637 },
        { 1383, "Snarl", "Orgrimmar", "H", 79.2, 22.4, 1454, 1637 },
        { 5511, "Therum Deepforge", "Stormwind City", "A", 63.4, 36.2, 1453, 1519 },
        { 3478, "Traugh", "The Barrens", "H", 51.2, 28.8, 1413, 17 },
    },
}
