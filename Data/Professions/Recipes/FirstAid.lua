-- Journal Assistant - First Aid recipe sources verified on Wowhead (WoW: Forever)
--
-- GENERATED 2026-11-20 from wowhead.com/forever spell, NPC and item pages:
--   req   = "Requires <Profession> (N)" on the spell page
--   npcs  = the spell's "Taught by" tab; zone, x, y, uiMapID from each NPC page's map
--   items = recipe items that teach it, with "Sold by" / "Dropped by" from the item page
-- Nothing here is guessed. Entries: { npcID, name, zone, faction (A/H/AH), x, y, uiMapID, areaID }
-- (zone is nil when only the area ID is known; the addon asks the game via C_Map.GetAreaInfo)

local _, ns = ...
local D = ns.Data

D.recipeTeachers["heavy linen bandage"] = { spell = 3276, prof = "FIRSTAID", req = 40,
    npcs = {
        { 251977, "Angelique Butler", "Alterac Mountains", "A", 17.2, 61, 1416, 36 },
        { 3373, "Arnok", "Orgrimmar", "H", 34, 84.4, 1454, 1637 },
        { 6094, "Byancie", "Teldrassil", "A", 55.2, 56.8, 1438, 141 },
        { 4211, "Dannelor", "Darnassus", "A", 51.4, 12.4, 1457, 1657 },
        { 3181, "Fremal Doohickey", "Wetlands", "A", 10.8, 61.2, 1437, 11 },
        { 4591, "Mary Edras", "Undercity", "H", 73.4, 55.4, 1458, 1497 },
        { 257007, "Melasa Fairmend", "Zephras Isle", "AH", 63, 72.4, 2521, 16593 },
        { 2329, "Michelle Belle", "Elwynn Forest", "A", 43.4, 65.6, 1429, 12 },
        { 257018, "Naleeia Tattermend", "Zephras Isle", "AH", 43, 46.2, 2521, 16593 },
        { 5150, "Nissa Firestone", "Ironforge", "A", 54.8, 58.4, 1455, 1537 },
        { 5759, "Nurse Neela", "Tirisfal Glades", "H", 61.8, 52.8, 1420, 85 },
        { 2798, "Pand Stonebinder", "Thunder Bluff", "H", 29.4, 21.4, 1456, 1638 },
        { 5943, "Rawrk", "Durotar", "H", 54, 42, 1411, 14 },
        { 2327, "Shaina Fuller", "Stormwind City", "A", 52.8, 44.8, 1453, 1519 },
        { 2326, "Thamner Pol", "Dun Morogh", "A", 47.2, 52.4, 1426, 1 },
        { 5939, "Vira Younghoof", "Mulgore", "H", 46, 63.8, 1412, 215 },
    },
}
D.recipeTeachers["heavy silk bandage"] = { spell = 7929, prof = "FIRSTAID", req = 125,
    items = {
        { item = 16112, name = "Manual: Heavy Silk Bandage",
          soldBy = {
            { 2805, "Deneb Walker", "Arathi Highlands", "A", 27, 58.8, 1417, 45 },
            { 13476, "Balai Lok'Wein", "Dustwallow Marsh", "H", 36.4, 30.4, 1445, 15 },
          },
        },
    },
}
D.recipeTeachers["heavy wool bandage"] = { spell = 3278, prof = "FIRSTAID", req = 115,
    npcs = {
        { 251977, "Angelique Butler", "Alterac Mountains", "A", 17.2, 61, 1416, 36 },
        { 3373, "Arnok", "Orgrimmar", "H", 34, 84.4, 1454, 1637 },
        { 6094, "Byancie", "Teldrassil", "A", 55.2, 56.8, 1438, 141 },
        { 4211, "Dannelor", "Darnassus", "A", 51.4, 12.4, 1457, 1657 },
        { 3181, "Fremal Doohickey", "Wetlands", "A", 10.8, 61.2, 1437, 11 },
        { 4591, "Mary Edras", "Undercity", "H", 73.4, 55.4, 1458, 1497 },
        { 257007, "Melasa Fairmend", "Zephras Isle", "AH", 63, 72.4, 2521, 16593 },
        { 2329, "Michelle Belle", "Elwynn Forest", "A", 43.4, 65.6, 1429, 12 },
        { 257018, "Naleeia Tattermend", "Zephras Isle", "AH", 43, 46.2, 2521, 16593 },
        { 5150, "Nissa Firestone", "Ironforge", "A", 54.8, 58.4, 1455, 1537 },
        { 5759, "Nurse Neela", "Tirisfal Glades", "H", 61.8, 52.8, 1420, 85 },
        { 2798, "Pand Stonebinder", "Thunder Bluff", "H", 29.4, 21.4, 1456, 1638 },
        { 5943, "Rawrk", "Durotar", "H", 54, 42, 1411, 14 },
        { 2327, "Shaina Fuller", "Stormwind City", "A", 52.8, 44.8, 1453, 1519 },
        { 2326, "Thamner Pol", "Dun Morogh", "A", 47.2, 52.4, 1426, 1 },
        { 5939, "Vira Younghoof", "Mulgore", "H", 46, 63.8, 1412, 215 },
    },
}
D.recipeTeachers["mageweave bandage"] = { spell = 10840, prof = "FIRSTAID", req = 150,
    items = {
        { item = 16113, name = "Manual: Mageweave Bandage",
          soldBy = {
            { 2805, "Deneb Walker", "Arathi Highlands", "A", 27, 58.8, 1417, 45 },
            { 13476, "Balai Lok'Wein", "Dustwallow Marsh", "H", 36.4, 30.4, 1445, 15 },
          },
        },
    },
}
D.recipeTeachers["silk bandage"] = { spell = 7928, prof = "FIRSTAID", req = 150,
    npcs = {
        { 251977, "Angelique Butler", "Alterac Mountains", "A", 17.2, 61, 1416, 36 },
        { 3373, "Arnok", "Orgrimmar", "H", 34, 84.4, 1454, 1637 },
        { 6094, "Byancie", "Teldrassil", "A", 55.2, 56.8, 1438, 141 },
        { 4211, "Dannelor", "Darnassus", "A", 51.4, 12.4, 1457, 1657 },
        { 3181, "Fremal Doohickey", "Wetlands", "A", 10.8, 61.2, 1437, 11 },
        { 4591, "Mary Edras", "Undercity", "H", 73.4, 55.4, 1458, 1497 },
        { 257007, "Melasa Fairmend", "Zephras Isle", "AH", 63, 72.4, 2521, 16593 },
        { 2329, "Michelle Belle", "Elwynn Forest", "A", 43.4, 65.6, 1429, 12 },
        { 257018, "Naleeia Tattermend", "Zephras Isle", "AH", 43, 46.2, 2521, 16593 },
        { 5150, "Nissa Firestone", "Ironforge", "A", 54.8, 58.4, 1455, 1537 },
        { 5759, "Nurse Neela", "Tirisfal Glades", "H", 61.8, 52.8, 1420, 85 },
        { 2798, "Pand Stonebinder", "Thunder Bluff", "H", 29.4, 21.4, 1456, 1638 },
        { 5943, "Rawrk", "Durotar", "H", 54, 42, 1411, 14 },
        { 2327, "Shaina Fuller", "Stormwind City", "A", 52.8, 44.8, 1453, 1519 },
        { 2326, "Thamner Pol", "Dun Morogh", "A", 47.2, 52.4, 1426, 1 },
        { 5939, "Vira Younghoof", "Mulgore", "H", 46, 63.8, 1412, 215 },
    },
}
D.recipeTeachers["wool bandage"] = { spell = 3277, prof = "FIRSTAID", req = 80,
    npcs = {
        { 251977, "Angelique Butler", "Alterac Mountains", "A", 17.2, 61, 1416, 36 },
        { 3373, "Arnok", "Orgrimmar", "H", 34, 84.4, 1454, 1637 },
        { 6094, "Byancie", "Teldrassil", "A", 55.2, 56.8, 1438, 141 },
        { 4211, "Dannelor", "Darnassus", "A", 51.4, 12.4, 1457, 1657 },
        { 3181, "Fremal Doohickey", "Wetlands", "A", 10.8, 61.2, 1437, 11 },
        { 4591, "Mary Edras", "Undercity", "H", 73.4, 55.4, 1458, 1497 },
        { 257007, "Melasa Fairmend", "Zephras Isle", "AH", 63, 72.4, 2521, 16593 },
        { 2329, "Michelle Belle", "Elwynn Forest", "A", 43.4, 65.6, 1429, 12 },
        { 257018, "Naleeia Tattermend", "Zephras Isle", "AH", 43, 46.2, 2521, 16593 },
        { 5150, "Nissa Firestone", "Ironforge", "A", 54.8, 58.4, 1455, 1537 },
        { 5759, "Nurse Neela", "Tirisfal Glades", "H", 61.8, 52.8, 1420, 85 },
        { 2798, "Pand Stonebinder", "Thunder Bluff", "H", 29.4, 21.4, 1456, 1638 },
        { 5943, "Rawrk", "Durotar", "H", 54, 42, 1411, 14 },
        { 2327, "Shaina Fuller", "Stormwind City", "A", 52.8, 44.8, 1453, 1519 },
        { 2326, "Thamner Pol", "Dun Morogh", "A", 47.2, 52.4, 1426, 1 },
        { 5939, "Vira Younghoof", "Mulgore", "H", 46, 63.8, 1412, 215 },
    },
}
