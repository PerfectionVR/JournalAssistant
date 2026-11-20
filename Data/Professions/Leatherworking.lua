-- Journal Assistant - Leatherworking data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Leatherworking. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("LEATHERWORKING", { name = "Leatherworking", skillLine = 165, kind = "craft", order = 6,
    icon = "Interface\\Icons\\Trade_LeatherWorking" })

D.trainers.LEATHERWORKING = {
    src("Simon Tanner", "Stormwind City", "Alliance", nil, nil, { note = "Old Town" }),
    src("Fimble Finespindle", "Ironforge", "Alliance"),
    src("Karolek", "Orgrimmar", "Horde"),
}

D.ranks.LEATHERWORKING = standard("LEATHERWORKING", { confidence = "classic",
    artisan = { src("Drakk Stonehand", "The Hinterlands", "Alliance", nil, nil, { note = "Aerie Peak" }) } })

D.guideRecipes.LEATHERWORKING = {
    { 1, 30, "Light Leather" }, { 30, 45, "Light Armor Kit" }, { 45, 55, "Cured Light Hide" },
    { 55, 85, "Embossed Leather Gloves" }, { 85, 100, "Fine Leather Belt" }, { 100, 115, "Dark Leather Pants" },
    { 115, 118, "Gray Leather Boots" }, { 118, 145, "Dark Leather Belt" }, { 125, 145, "Cured Heavy Hide" },
    { 145, 155, "Toughened Leather Gloves" }, { 155, 185, "Barbaric Shoulders" }, { 160, 190, "Gem-studded Leather Belt" },
    { 190, 200, "Guardian Gloves" }, { 200, 210, "Thick Armor Kit" }, { 210, 240, "Nightscape Pants" },
    { 225, 230, "Cured Rugged Hide" }, { 240, 270, "Wicked Leather Gauntlets" }, { 255, 260, "Heavy Scorpid Bracers" },
    { 270, 300, "Heavy Scorpid Helm" },
}

D.recipeVendors.LEATHERWORKING = {
    { skill = 160, recipe = "Gem-studded Leather Belt", item = "Pattern: Gem-studded Leather Belt", npc = "Rikqiz", zone = "Stranglethorn Vale",
      note = "Booty Bay" },
    { skill = 240, recipe = "Wicked Leather Gauntlets", item = "Pattern: Wicked Leather Gauntlets", npc = "Leonard Porter", zone = "Western Plaguelands" },
    { skill = 255, recipe = "Heavy Scorpid Bracers", item = "Pattern: Heavy Scorpid Bracers", npc = "Zannok Hidepiercer", zone = "Silithus" },
    { skill = 270, recipe = "Heavy Scorpid Helm", item = "Pattern: Heavy Scorpid Helm", npc = "Zannok Hidepiercer", zone = "Silithus" },
}
