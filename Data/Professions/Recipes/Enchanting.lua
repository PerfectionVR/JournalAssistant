-- Journal Assistant - Enchanting recipe sources verified on Wowhead (WoW: Forever)
--
-- GENERATED 2026-11-20 from wowhead.com/forever spell, NPC and item pages:
--   req   = "Requires <Profession> (N)" on the spell page
--   npcs  = the spell's "Taught by" tab; zone, x, y, uiMapID from each NPC page's map
--   items = recipe items that teach it, with "Sold by" / "Dropped by" from the item page
-- Nothing here is guessed. Entries: { npcID, name, zone, faction (A/H/AH), x, y, uiMapID, areaID }
-- (zone is nil when only the area ID is known; the addon asks the game via C_Map.GetAreaInfo)

local _, ns = ...
local D = ns.Data

D.recipeTeachers["enchant boots - stamina"] = { spell = 13836, prof = "ENCHANTING", req = 215,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
    },
}
D.recipeTeachers["enchant bracer - lesser stamina"] = { spell = 13501, prof = "ENCHANTING", req = 130,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["enchant bracer - lesser strength"] = { spell = 13536, prof = "ENCHANTING", req = 140,
    items = {
        { item = 11101, name = "Formula: Enchant Bracer - Lesser Strength",
          soldBy = {
            { 3954, "Dalria", "Ashenvale", "A", 35, 52, 1440, 331 },
            { 12043, "Kulwia", "Stonetalon Mountains", "H", 45.4, 59.4, 1442, 406 },
          },
        },
    },
}
D.recipeTeachers["enchant bracer - minor stamina"] = { spell = 7457, prof = "ENCHANTING", req = 50,
    npcs = {
        { 3606, "Alanna Raveneye", "Teldrassil", "A", 36.8, 34.2, 1438, 141 },
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11068, "Betty Quin", "Stormwind City", "A", 53, 73.8, 1453, 1519 },
        { 257004, "Eaysaa Brightgust", "Zephras Isle", "AH", 59.2, 76.2, 2521, 16593 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11066, "Jhag", "Orgrimmar", "H", 53.4, 38.2, 1454, 1637 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 11070, "Lalina Summermoon", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 11067, "Malcomb Wynn", "Undercity", "H", 62.2, 60.4, 1458, 1497 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 11071, "Mot Dawnstrider", "Thunder Bluff", "H", 43.8, 37.8, 1456, 1638 },
        { 257020, "Nasalanna Windsinger", "Zephras Isle", "AH", 43.2, 43.2, 2521, 16593 },
        { 266881, "Pa'zula", "Durotar", "H", 56.4, 73.6, 1411, 14 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 11065, "Thonys Pillarstone", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 5695, "Vance Undergloom", "Tirisfal Glades", "H", 61.6, 51.4, 1420, 85 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["enchant bracer - strength"] = { spell = 13661, prof = "ENCHANTING", req = 180,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
    },
}
D.recipeTeachers["enchant chest - minor absorption"] = { spell = 7426, prof = "ENCHANTING", req = 40,
    npcs = {
        { 3606, "Alanna Raveneye", "Teldrassil", "A", 36.8, 34.2, 1438, 141 },
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11068, "Betty Quin", "Stormwind City", "A", 53, 73.8, 1453, 1519 },
        { 257004, "Eaysaa Brightgust", "Zephras Isle", "AH", 59.2, 76.2, 2521, 16593 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11066, "Jhag", "Orgrimmar", "H", 53.4, 38.2, 1454, 1637 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 11070, "Lalina Summermoon", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 11067, "Malcomb Wynn", "Undercity", "H", 62.2, 60.4, 1458, 1497 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 11071, "Mot Dawnstrider", "Thunder Bluff", "H", 43.8, 37.8, 1456, 1638 },
        { 257020, "Nasalanna Windsinger", "Zephras Isle", "AH", 43.2, 43.2, 2521, 16593 },
        { 266881, "Pa'zula", "Durotar", "H", 56.4, 73.6, 1411, 14 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 11065, "Thonys Pillarstone", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 5695, "Vance Undergloom", "Tirisfal Glades", "H", 61.6, 51.4, 1420, 85 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["enchant chest - superior stamina"] = { spell = 13858, prof = "ENCHANTING", req = 220,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
    },
}
D.recipeTeachers["enchant cloak - greater defense"] = { spell = 13746, prof = "ENCHANTING", req = 205,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
    },
}
D.recipeTeachers["enchant cloak - minor agility"] = { spell = 13419, prof = "ENCHANTING", req = 110,
    items = {
        { item = 11039, name = "Formula: Enchant Cloak - Minor Agility",
          soldBy = {
            { 3954, "Dalria", "Ashenvale", "A", 35, 52, 1440, 331 },
            { 12043, "Kulwia", "Stonetalon Mountains", "H", 45.4, 59.4, 1442, 406 },
          },
          droppedBy = {
            { 121, "Defias Pathstalker", nil, 15, 16, 40 },
            { 122, "Defias Highwayman", nil, 17, 18, 40 },
            { 124, "Riverpaw Brute", nil, 15, 16, 40 },
            { 126, "Murloc Coastrunner", nil, 12, 13, 40 },
            { 213, "Starving Dire Wolf", nil, 19, 20, 10 },
            { 218, "Grave Robber", nil, 24, 25, 10 },
          },
        },
    },
}
D.recipeTeachers["enchant cloak - superior defense"] = { spell = 20015, prof = "ENCHANTING", req = 285,
    items = {
        { item = 16224, name = "Formula: Enchant Cloak - Superior Defense",
          soldBy = {
            { 12022, "Lorelae Wintersong", "Moonglade", "AH", 48.4, 40.2, 1450, 493 },
          },
          droppedBy = {
            { 11444, "Gordok Mage-Lord", nil, 57, 58, 2557 },
          },
        },
    },
}
D.recipeTeachers["enchant gloves - agility"] = { spell = 13815, prof = "ENCHANTING", req = 210,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
    },
}
D.recipeTeachers["enchant shield - greater stamina"] = { spell = 20017, prof = "ENCHANTING", req = 265,
    items = {
        { item = 16217, name = "Formula: Enchant Shield - Greater Stamina",
          soldBy = {
            { 4229, "Mythrin'dir", "Darnassus", "A", 61, 17.4, 1457, 1657 },
            { 4561, "Daniel Bartlett", "Undercity", "H", 64, 38.8, 1458, 1497 },
          },
        },
    },
}
D.recipeTeachers["greater magic wand"] = { spell = 14807, prof = "ENCHANTING", req = 70,
    npcs = {
        { 3606, "Alanna Raveneye", "Teldrassil", "A", 36.8, 34.2, 1438, 141 },
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11068, "Betty Quin", "Stormwind City", "A", 53, 73.8, 1453, 1519 },
        { 257004, "Eaysaa Brightgust", "Zephras Isle", "AH", 59.2, 76.2, 2521, 16593 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11066, "Jhag", "Orgrimmar", "H", 53.4, 38.2, 1454, 1637 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 11070, "Lalina Summermoon", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 11067, "Malcomb Wynn", "Undercity", "H", 62.2, 60.4, 1458, 1497 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 11071, "Mot Dawnstrider", "Thunder Bluff", "H", 43.8, 37.8, 1456, 1638 },
        { 257020, "Nasalanna Windsinger", "Zephras Isle", "AH", 43.2, 43.2, 2521, 16593 },
        { 266881, "Pa'zula", "Durotar", "H", 56.4, 73.6, 1411, 14 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 11065, "Thonys Pillarstone", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 5695, "Vance Undergloom", "Tirisfal Glades", "H", 61.6, 51.4, 1420, 85 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["lesser magic wand"] = { spell = 14293, prof = "ENCHANTING", req = 10,
    npcs = {
        { 3606, "Alanna Raveneye", "Teldrassil", "A", 36.8, 34.2, 1438, 141 },
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11068, "Betty Quin", "Stormwind City", "A", 53, 73.8, 1453, 1519 },
        { 257004, "Eaysaa Brightgust", "Zephras Isle", "AH", 59.2, 76.2, 2521, 16593 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11066, "Jhag", "Orgrimmar", "H", 53.4, 38.2, 1454, 1637 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 11070, "Lalina Summermoon", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 11067, "Malcomb Wynn", "Undercity", "H", 62.2, 60.4, 1458, 1497 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 11071, "Mot Dawnstrider", "Thunder Bluff", "H", 43.8, 37.8, 1456, 1638 },
        { 257020, "Nasalanna Windsinger", "Zephras Isle", "AH", 43.2, 43.2, 2521, 16593 },
        { 266881, "Pa'zula", "Durotar", "H", 56.4, 73.6, 1411, 14 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 11065, "Thonys Pillarstone", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 5695, "Vance Undergloom", "Tirisfal Glades", "H", 61.6, 51.4, 1420, 85 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["lesser mana oil"] = { spell = 25127, prof = "ENCHANTING", req = 250,
    items = {
        { item = 20754, name = "Formula: Lesser Mana Oil",
          soldBy = {
            { 12944, "Lokhtos Darkbargainer", nil, "AH", nil, nil, nil, nil },
            { 15419, "Kania", "Silithus", "AH", 52, 39.4, 1451, 1377 },
          },
        },
    },
}
D.recipeTeachers["runed arcanite rod"] = { spell = 20051, prof = "ENCHANTING", req = 290,
    items = {
        { item = 16243, name = "Formula: Runed Arcanite Rod",
          soldBy = {
            { 12022, "Lorelae Wintersong", "Moonglade", "AH", 48.4, 40.2, 1450, 493 },
          },
        },
    },
}
D.recipeTeachers["runed golden rod"] = { spell = 13628, prof = "ENCHANTING", req = 150,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["runed silver rod"] = { spell = 7795, prof = "ENCHANTING", req = 100,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 5157, "Gimble Thistlefuzz", "Ironforge", "A", 59, 45.2, 1455, 1537 },
        { 3345, "Godan", "Orgrimmar", "H", 53.8, 38.4, 1454, 1637 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 4616, "Lavinia Crowe", "Undercity", "H", 62.2, 61.6, 1458, 1497 },
        { 1317, "Lucan Cordell", "Stormwind City", "A", 53, 74.2, 1453, 1519 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 4213, "Taladan", "Darnassus", "A", 58.4, 13.2, 1457, 1657 },
        { 3011, "Teg Dawnstrider", "Thunder Bluff", "H", 44.8, 37.4, 1456, 1638 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
        { 7949, "Xylinnia Starshine", "Feralas", "A", 31.4, 44.2, 1444, 357 },
    },
}
D.recipeTeachers["runed truesilver rod"] = { spell = 13702, prof = "ENCHANTING", req = 200,
    npcs = {
        { 11073, "Annora", nil, "AH", nil, nil, nil, 1337 },
        { 11074, "Hgarth", "Stonetalon Mountains", "H", 49.2, 57.2, 1442, 406 },
        { 11072, "Kitta Firewind", "Elwynn Forest", "A", 64.8, 70.4, 1429, 12 },
        { 259287, "Melanie Sable", "Riverglades", "AH", 66.2, 83.2, 2548, 16591 },
        { 251978, "Vanessa Sellers", "Alterac Mountains", "A", 16.6, 62.6, 1416, 36 },
    },
}
