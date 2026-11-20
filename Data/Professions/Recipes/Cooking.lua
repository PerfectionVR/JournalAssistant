-- Journal Assistant - Cooking recipe sources verified on Wowhead (WoW: Forever)
--
-- GENERATED 2026-11-20 from wowhead.com/forever spell, NPC and item pages:
--   req   = "Requires <Profession> (N)" on the spell page
--   npcs  = the spell's "Taught by" tab; zone, x, y, uiMapID from each NPC page's map
--   items = recipe items that teach it, with "Sold by" / "Dropped by" from the item page
-- Nothing here is guessed. Entries: { npcID, name, zone, faction (A/H/AH), x, y, uiMapID, areaID }
-- (zone is nil when only the area ID is known; the addon asks the game via C_Map.GetAreaInfo)

local _, ns = ...
local D = ns.Data

D.recipeTeachers["brilliant smallfish"] = { spell = 7751, prof = "COOKING", req = 1,
    items = {
        { item = 6325, name = "Recipe: Brilliant Smallfish",
          soldBy = {
            { 66, "Tharynn Bouden", "Elwynn Forest", "A", 41.8, 67, 1429, 12 },
            { 1684, "Khara Deepwater", "Loch Modan", "A", 39.4, 39.2, 1432, 38 },
            { 3029, "Sewa Mistrunner", "Thunder Bluff", "H", 55.2, 48, 1456, 1638 },
            { 3550, "Martine Tramblay", "Tirisfal Glades", "H", 65.8, 59.4, 1420, 85 },
            { 4265, "Nyoma", "Teldrassil", "A", 57.2, 61.2, 1438, 141 },
            { 4574, "Lizbeth Cromwell", "Undercity", "H", 81, 29.2, 1458, 1497 },
            { 5494, "Catherine Leland", "Stormwind City", "A", 55, 69.4, 1453, 1519 },
            { 5940, "Harn Longcast", "Mulgore", "H", 46.6, 59.2, 1412, 215 },
            { 8508, "Gretta Ganter", "Dun Morogh", "A", 31.4, 44.6, 1426, 1 },
          },
        },
    },
}
D.recipeTeachers["bristle whisker catfish"] = { spell = 7755, prof = "COOKING", req = 100,
    items = {
        { item = 6330, name = "Recipe: Bristle Whisker Catfish",
          soldBy = {
            { 2383, "Lindea Rabonne", "Hillsbrad Foothills", "A", 50, 62.4, 1424, 267 },
            { 2397, "Derak Nightfall", "Hillsbrad Foothills", "H", 63, 19.4, 1424, 267 },
            { 3027, "Naal Mistrunner", "Thunder Bluff", "H", 50.2, 51.6, 1456, 1638 },
            { 3029, "Sewa Mistrunner", "Thunder Bluff", "H", 55.2, 48, 1456, 1638 },
            { 3497, "Kilxx", "The Barrens", "AH", 62.8, 38.2, 1413, 17 },
            { 4553, "Ronald Burch", "Undercity", "H", 62.4, 43.4, 1458, 1497 },
            { 5494, "Catherine Leland", "Stormwind City", "A", 55, 69.4, 1453, 1519 },
            { 260487, "Gritta Chumwater", "Riverglades", "AH", 78.4, 55, 2548, 16591 },
          },
        },
    },
}
D.recipeTeachers["longjaw mud snapper"] = { spell = 7753, prof = "COOKING", req = 50,
    items = {
        { item = 6328, name = "Recipe: Longjaw Mud Snapper",
          soldBy = {
            { 66, "Tharynn Bouden", "Elwynn Forest", "A", 41.8, 67, 1429, 12 },
            { 1684, "Khara Deepwater", "Loch Modan", "A", 39.4, 39.2, 1432, 38 },
            { 3027, "Naal Mistrunner", "Thunder Bluff", "H", 50.2, 51.6, 1456, 1638 },
            { 4265, "Nyoma", "Teldrassil", "A", 57.2, 61.2, 1438, 141 },
            { 4574, "Lizbeth Cromwell", "Undercity", "H", 81, 29.2, 1458, 1497 },
            { 5162, "Tansy Puddlefizz", "Ironforge", "A", 47.8, 6.4, 1455, 1537 },
            { 5748, "Killian Sanatha", "Silverpine Forest", "H", 33, 17.4, 1421, 130 },
            { 5940, "Harn Longcast", "Mulgore", "H", 46.6, 59.2, 1412, 215 },
          },
        },
    },
}
D.recipeTeachers["mightfish steak"] = { spell = 18246, prof = "COOKING", req = 275,
    items = {
        { item = 13948, name = "Recipe: Mightfish Steak",
          soldBy = {
            { 7947, "Vivianna", "Feralas", "A", 31.2, 43.4, 1444, 357 },
            { 8145, "Sheendra Tallgrass", "Feralas", "H", 74.4, 42.8, 1444, 357 },
          },
        },
    },
}
D.recipeTeachers["mithril headed trout"] = { spell = 20916, prof = "COOKING", req = 175,
    items = {
        { item = 17062, name = "Recipe: Mithril Head Trout",
          soldBy = {
            { 2383, "Lindea Rabonne", "Hillsbrad Foothills", "A", 50, 62.4, 1424, 267 },
            { 2664, "Kelsey Yance", "Stranglethorn Vale", "AH", 28.2, 74.4, 1434, 33 },
            { 3178, "Stuart Fleming", "Wetlands", "A", 8, 58.2, 1437, 11 },
            { 3333, "Shankys", "Orgrimmar", "H", 69.4, 29, 1454, 1637 },
            { 4307, "Heldan Galesong", "Darkshore", "A", 37, 56.2, 1439, 148 },
            { 4574, "Lizbeth Cromwell", "Undercity", "H", 81, 29.2, 1458, 1497 },
            { 5162, "Tansy Puddlefizz", "Ironforge", "A", 47.8, 6.4, 1455, 1537 },
            { 12033, "Wulan", "Desolace", "H", 26.2, 69.8, 1443, 405 },
            { 12962, "Wik'Tar", "Ashenvale", "H", 11.8, 34, 1440, 331 },
          },
        },
    },
}
D.recipeTeachers["spotted yellowtail"] = { spell = 18238, prof = "COOKING", req = 225,
    items = {
        { item = 13939, name = "Recipe: Spotted Yellowtail",
          soldBy = {
            { 8137, "Gikkix", "Tanaris", "AH", 66.6, 22, 1446, 440 },
          },
        },
    },
}
