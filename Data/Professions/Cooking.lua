-- Journal Assistant - Cooking data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Cooking. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("COOKING", { name = "Cooking", skillLine = 185, kind = "craft", order = 10,
    icon = "Interface\\Icons\\INV_Misc_Food_15" })

D.trainers.COOKING = {
    src("Stephen Ryback", "Stormwind City", "Alliance", 75.8, 36.9, { note = "Old Town, Pig and Whistle" }),
    src("Daryl Riknussun", "Ironforge", "Alliance"),
    src("Zamja", "Orgrimmar", "Horde"),
}

D.ranks.COOKING = {
    { rank = "Journeyman", fromCap = 75, cap = 150, reqSkill = 50, minLevel = 10, method = "trainer",
      sources = D.trainers.COOKING, confidence = "forever-guide" },
    { rank = "Expert", fromCap = 150, cap = 225, reqSkill = 125, minLevel = 1, method = "book",
      item = "Expert Cookbook", itemID = 16072, tradeable = true,
      sources = {
          src("Shandrina", "Ashenvale", "Alliance", 49.6, 67.0, { note = "Mystral Lake" }),
          src("Wulan", "Desolace", "Horde", 26.2, 69.8, { note = "Shadowprey Village" }),
      },
      confidence = "forever-guide",
      note = "Read it at 125+ or Cooking stops at 150. Also sold on the Auction House." },
    { rank = "Artisan", fromCap = 225, cap = 300, reqSkill = 225, minLevel = 35, method = "quest",
      item = "Clamlette Surprise (quest)",
      sources = { src("Dirge Quikcleave", "Tanaris", nil, 52.6, 28.1, { note = "Gadgetzan inn" }) },
      confidence = "forever-guide",
      note = "Needs 12 Giant Egg, 10 Zesty Clam Meat, 20 Alterac Swiss (Ben Trias, Stormwind)." },
}

D.guideRecipes.COOKING = { -- wow-professions / Warcraft Tavern
    { 1, 50, "Brilliant Smallfish" }, { 1, 50, "Slitherskin Mackerel" }, { 50, 100, "Longjaw Mud Snapper" },
    { 100, 175, "Bristle Whisker Catfish" }, { 150, 175, "Curiously Tasty Omelet" },
    { 175, 250, "Mithril Head Trout" }, { 175, 250, "Mithril Headed Trout" }, { 250, 285, "Filet of Redgill" },
    { 285, 300, "Nightfin Soup" },
}

D.recipeVendors.COOKING = {
    { skill = 100, recipe = "Bristle Whisker Catfish", item = "Recipe: Bristle Whisker Catfish",
      npc = "Catherine Leland", zone = "Stormwind City", x = 45.8, y = 58.2, note = "Canals fishing shop" },
    { skill = 150, recipe = "Curiously Tasty Omelet", item = "Recipe: Curiously Tasty Omelet",
      npc = "Kendor Kabonka", zone = "Stormwind City", x = 74.6, y = 37.6, note = "Old Town" },
    { skill = 175, recipe = "Mithril Head Trout", item = "Recipe: Mithril Head Trout",
      npc = "Stuart Fleming", zone = "Wetlands", x = 8.2, y = 58.6, note = "Menethil Harbor",
      alt = "Kelsey Yance (Booty Bay 28.2, 74.4), Lindea Rabonne (Southshore 50.6, 61.0)" },
}

D.tips.COOKING = "Forever requires a fire to cook - craft a Basic Campfire Kit (Simple Wood + Flint and Tinder) if none is near."
