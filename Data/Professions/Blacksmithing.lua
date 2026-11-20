-- Journal Assistant - Blacksmithing data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Blacksmithing. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("BLACKSMITHING", { name = "Blacksmithing", skillLine = 164, kind = "craft", order = 5,
    icon = "Interface\\Icons\\Trade_BlackSmithing" })

D.trainers.BLACKSMITHING = {
    src("Therum Deepforge", "Stormwind City", "Alliance"),
    src("Rotgath Stonebeard", "Ironforge", "Alliance"),
    src("Saru Steelfury", "Orgrimmar", "Horde"),
}

D.ranks.BLACKSMITHING = standard("BLACKSMITHING", {
    expert = { src("Bengus Deepforge", "Ironforge", nil, nil, nil, { note = "The Great Forge" }) },
    artisan = { src("Brikk Keencraft", "Stranglethorn Vale", nil, nil, nil,
        { note = "Booty Bay, behind the shops", area = { min = 30, name = "Stranglethorn road" } }) } })

D.guideRecipes.BLACKSMITHING = { -- wow-professions (Wowhead differs above 240: Ebon Shiv / Bold Dirk)
    { 1, 25, "Rough Sharpening Stone" }, { 25, 50, "Rough Grinding Stone" }, { 50, 75, "Coarse Grinding Stone" },
    { 75, 80, "Silver Rod" }, { 80, 95, "Runed Copper Belt" }, { 95, 125, "Patterned Bronze Bracers" },
    { 100, 112, "Heavy Grinding Stone" }, { 125, 140, "Bronze Shortsword" }, { 129, 150, "Bronze Warhammer" },
    { 150, 175, "Green Iron Bracers" }, { 175, 180, "Solid Grinding Stone" }, { 180, 195, "Golden Scale Bracers" },
    { 195, 210, "Mithril Plate Pants" }, { 210, 215, "Heavy Mithril Axe" }, { 215, 225, "Heavy Mithril Breastplate" },
    { 215, 225, "Mithril Spurs" }, { 225, 235, "Dense Sharpening Stone" }, { 225, 235, "Dense Weightstone" },
    { 230, 240, "Heavy Mithril Boots" }, { 240, 245, "Imperial Plate Belt" }, { 245, 270, "Imperial Plate Bracers" },
    { 257, 270, "Ebon Shiv" }, { 270, 290, "Imperial Plate Boots" }, { 270, 300, "Bold Dirk" },
    { 290, 300, "Imperial Plate Leggings" },
}

D.recipeVendors.BLACKSMITHING = {
    { skill = 240, recipe = "Imperial Plate Belt", item = "Plans: Imperial Plate Belt", kind = "quest",
      npc = "Derotain Mudsipper", zone = "Tanaris", note = "Gadgetzan; quest needs level 50 and Thorium Bars" },
    { skill = 257, recipe = "Ebon Shiv", item = "Plans: Ebon Shiv", npc = "Magnus Frostwake", zone = "Western Plaguelands" },
    { skill = 270, recipe = "Bold Dirk", item = "Plans: Bold Dirk", npc = "Pexmit" },
}
