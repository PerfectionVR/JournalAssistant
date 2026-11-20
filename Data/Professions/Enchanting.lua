-- Journal Assistant - Enchanting data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Enchanting. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("ENCHANTING", { name = "Enchanting", skillLine = 333, kind = "craft", order = 9,
    icon = "Interface\\Icons\\Trade_Engraving" })

D.trainers.ENCHANTING = {
    src("Lucan Cordell", "Stormwind City", "Alliance", nil, nil, { note = "Mage Quarter" }),
    src("Gimble Thistlefuzz", "Ironforge", "Alliance"),
    src("Jhag", "Orgrimmar", "Horde"),
}

D.ranks.ENCHANTING = standard("ENCHANTING", { confidence = "classic",
    artisan = { src("Annora", "Badlands", nil, nil, nil, { note = "inside Uldaman" }) } })

D.guideRecipes.ENCHANTING = {
    { 1, 2, "Runed Copper Rod" }, { 20, 79, "Lesser Magic Wand" }, { 79, 90, "Enchant Chest - Minor Absorption" },
    { 90, 100, "Enchant Bracer - Minor Stamina" }, { 100, 101, "Runed Silver Rod" }, { 101, 110, "Greater Magic Wand" },
    { 110, 135, "Enchant Cloak - Minor Agility" }, { 135, 155, "Enchant Bracer - Lesser Stamina" },
    { 155, 156, "Runed Golden Rod" }, { 156, 185, "Enchant Bracer - Lesser Strength" },
    { 185, 220, "Enchant Bracer - Strength" }, { 200, 201, "Runed Truesilver Rod" },
    { 220, 225, "Enchant Cloak - Greater Defense" }, { 225, 230, "Enchant Gloves - Agility" },
    { 230, 235, "Enchant Boots - Stamina" }, { 235, 250, "Enchant Chest - Superior Stamina" },
    { 250, 265, "Lesser Mana Oil" }, { 265, 294, "Enchant Shield - Greater Stamina" },
    { 294, 295, "Runed Arcanite Rod" }, { 295, 300, "Enchant Cloak - Superior Defense" },
}

D.recipeVendors.ENCHANTING = {
    { skill = 110, recipe = "Enchant Cloak - Minor Agility", item = "Formula: Enchant Cloak - Minor Agility", npc = "Dalria", zone = "Ashenvale" },
    { skill = 156, recipe = "Enchant Bracer - Lesser Strength", item = "Formula: Enchant Bracer - Lesser Strength", npc = "Dalria", zone = "Ashenvale" },
    { skill = 250, recipe = "Lesser Mana Oil", item = "Formula: Lesser Mana Oil", npc = "Lokhtos Darkbargainer", note = "Blackrock Depths" },
    { skill = 265, recipe = "Enchant Shield - Greater Stamina", item = "Formula: Enchant Shield - Greater Stamina", npc = "Mythrin'dir", zone = "Darnassus" },
    { skill = 294, recipe = "Runed Arcanite Rod", item = "Formula: Runed Arcanite Rod", npc = "Lorelae Wintersong", zone = "Moonglade" },
    { skill = 295, recipe = "Enchant Cloak - Superior Defense", item = "Formula: Enchant Cloak - Superior Defense", npc = "Lorelae Wintersong", zone = "Moonglade" },
}
