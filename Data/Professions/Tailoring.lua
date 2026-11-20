-- Journal Assistant - Tailoring data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Tailoring. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("TAILORING", { name = "Tailoring", skillLine = 197, kind = "craft", order = 7,
    icon = "Interface\\Icons\\Trade_Tailoring" })

D.trainers.TAILORING = {
    src("Georgio Bolero", "Stormwind City", "Alliance", nil, nil, { note = "Mage Quarter" }),
    src("Jormund Stonebrow", "Ironforge", "Alliance"),
    src("Magar", "Orgrimmar", "Horde"),
}

D.ranks.TAILORING = standard("TAILORING", { confidence = "classic",
    artisan = { src("Timothy Worthington", "Dustwallow Marsh", "Alliance", nil, nil, { note = "Theramore Isle" }) } })

D.guideRecipes.TAILORING = {
    { 1, 43, "Bolt of Linen Cloth" }, { 43, 45, "Brown Linen Vest" }, { 45, 70, "Linen Belt" },
    { 70, 75, "Reinforced Linen Cape" }, { 75, 81, "Bolt of Woolen Cloth" }, { 81, 100, "Woolen Cape" },
    { 100, 110, "Bolt of Silk Cloth" }, { 110, 125, "Double-stitched Woolen Shoulders" }, { 125, 132, "Azure Silk Hood" },
    { 132, 139, "Lesser Wizard's Robe" }, { 139, 140, "Formal White Shirt" }, { 140, 149, "Bolt of Mageweave" },
    { 149, 160, "Earthen Vest" }, { 160, 170, "Robe of Power" }, { 170, 180, "Black Mageweave Vest" },
    { 180, 190, "Orange Mageweave Shirt" }, { 190, 205, "Black Mageweave Gloves" }, { 205, 214, "Bolt of Runecloth" },
    { 214, 234, "Runecloth Belt" }, { 234, 250, "Runecloth Cloak" }, { 250, 260, "Runecloth Boots" },
    { 260, 280, "Runecloth Cuffs" }, { 280, 285, "Wisdom of the Timbermaw" }, { 285, 292, "Venomspew Gloves" },
    { 292, 300, "Venomspew Cord" },
}

D.recipeVendors.TAILORING = {
    { skill = 234, recipe = "Runecloth Cloak", item = "Pattern: Runecloth Cloak", npc = "Darnall", zone = "Moonglade" },
    { skill = 250, recipe = "Runecloth Boots", item = "Pattern: Runecloth Boots", npc = "Darnall", zone = "Moonglade" },
    { skill = 260, recipe = "Runecloth Cuffs", item = "Pattern: Runecloth Cuffs", npc = "Pexmit" },
    { skill = 280, recipe = "Wisdom of the Timbermaw", item = "Pattern: Wisdom of the Timbermaw", npc = "Meilosh", zone = "Felwood",
      note = "Timbermaw Hold, needs Timbermaw reputation" },
    { skill = 285, recipe = "Venomspew Gloves", item = "Pattern: Venomspew Gloves", npc = "Mishta" },
    { skill = 292, recipe = "Venomspew Cord", item = "Pattern: Venomspew Cord", npc = "Mishta" },
}
