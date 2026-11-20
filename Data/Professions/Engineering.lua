-- Journal Assistant - Engineering data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Engineering. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("ENGINEERING", { name = "Engineering", skillLine = 202, kind = "craft", order = 8,
    icon = "Interface\\Icons\\Trade_Engineering" })

D.trainers.ENGINEERING = {
    src("Lilliam Sparkspindle", "Stormwind City", "Alliance"),
    src("Trixie Quikswitch", "Ironforge", "Alliance"),
    src("Roxxik", "Orgrimmar", "Horde"),
}

D.ranks.ENGINEERING = standard("ENGINEERING", {
    expert = { src("Springspindle Fizzlegear", "Ironforge", nil, nil, nil, { note = "Tinker Town" }) },
    artisan = { src("Buzzek Bracketswing", "Tanaris", nil, nil, nil, { note = "Gadgetzan, by the inn mailbox" }) } })

D.guideRecipes.ENGINEERING = {
    { 1, 30, "Rough Blasting Powder" }, { 30, 50, "Handful of Copper Bolts" }, { 50, 51, "Arclight Spanner" },
    { 51, 75, "Rough Copper Bomb" }, { 75, 90, "Coarse Blasting Powder" }, { 90, 100, "Coarse Dynamite" },
    { 100, 105, "Silver Contact" }, { 105, 125, "Bronze Tube" }, { 125, 135, "Standard Scope" },
    { 135, 150, "Heavy Blasting Powder" }, { 135, 150, "Whirring Bronze Gizmo" }, { 150, 160, "Bronze Framework" },
    { 160, 175, "Explosive Sheep" }, { 175, 194, "Solid Blasting Powder" }, { 194, 195, "Gyromatic Micro-Adjustor" },
    { 195, 200, "Mithril Tube" }, { 200, 215, "Unstable Trigger" }, { 215, 238, "Mithril Casing" },
    { 238, 250, "Hi-Explosive Bomb" }, { 250, 260, "Dense Blasting Powder" }, { 260, 285, "Thorium Widget" },
    { 280, 300, "Thorium Tube" },
}

D.recipeVendors.ENGINEERING = {
    { skill = 260, recipe = "Thorium Widget", item = "Schematic: Thorium Widget", npc = "Gearcutter Cogspinner", zone = "Ironforge" },
    { skill = 280, recipe = "Thorium Tube", item = "Schematic: Thorium Tube", npc = "Xizzer Fizzbolt", zone = "Winterspring",
      note = "Everlook; bind on pickup in Forever" },
}
