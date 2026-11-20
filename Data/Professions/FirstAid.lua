-- Journal Assistant - First Aid data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for First Aid. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("FIRSTAID", { name = "First Aid", skillLine = 129, kind = "craft", order = 12,
    icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice" })

D.trainers.FIRSTAID = {
    src("Shaina Fuller", "Stormwind City", "Alliance", 53.0, 44.7, { note = "Cathedral Square" }),
    src("Nissa Firestone", "Ironforge", "Alliance", 55.1, 58.3, { note = "The Great Forge" }),
    src("Fremal Doohickey", "Wetlands", "Alliance", 10.8, 61.4, { note = "Menethil Harbor" }),
    src("Michelle Belle", "Elwynn Forest", "Alliance", 43.4, 65.6, { note = "Goldshire" }),
    src("Arnok", "Orgrimmar", "Horde"),
}

D.ranks.FIRSTAID = {
    { rank = "Journeyman", fromCap = 75, cap = 150, reqSkill = 50, minLevel = 1, method = "trainer",
      sources = D.trainers.FIRSTAID, confidence = "forever-guide" },
    { rank = "Expert", fromCap = 150, cap = 225, reqSkill = 125, minLevel = 1, method = "book",
      item = "Expert First Aid - Under Wraps", itemID = 16084, tradeable = true,
      sources = {
          src("Deneb Walker", "Arathi Highlands", "Alliance", 26.97, 58.83,
              { note = "Stromgarde Keep", area = { min = 36, name = "Stromgarde (level 36-40 Syndicate)" } }),
          src("Balai Lok'Wein", "Dustwallow Marsh", "Horde", 36.4, 30.4, { note = "Brackenwall Village" }),
      },
      confidence = "forever-guide",
      note = "The book is tradeable: buy it on the Auction House if Stromgarde is too dangerous. Learn it as soon as you reach 125." },
    { rank = "Artisan", fromCap = 225, cap = 300, reqSkill = 225, minLevel = 35, method = "quest",
      item = "Triage (quest)",
      sources = {
          src("Doctor Gustaf VanHowzen", "Dustwallow Marsh", "Alliance", 67.76, 48.97, { note = "Theramore Isle" }),
          src("Doctor Gregory Victor", "Arathi Highlands", "Horde", 73.4, 36.8, { note = "Hammerfall" }),
      },
      confidence = "forever-guide" },
}

D.guideRecipes.FIRSTAID = { -- Warcraft Tavern / Method (bandage route; healing potions are First Aid in Forever)
    { 1, 40, "Linen Bandage" }, { 40, 80, "Heavy Linen Bandage" }, { 80, 115, "Wool Bandage" },
    { 115, 150, "Heavy Wool Bandage" }, { 150, 180, "Silk Bandage" }, { 180, 210, "Heavy Silk Bandage" },
    { 210, 240, "Mageweave Bandage" }, { 240, 260, "Heavy Mageweave Bandage" }, { 260, 290, "Runecloth Bandage" },
    { 290, 300, "Heavy Runecloth Bandage" },
    { 110, 150, "Healing Potion" }, { 155, 180, "Greater Healing Potion" }, { 215, 230, "Superior Healing Potion" },
    { 275, 300, "Major Healing Potion" },
}

D.recipeVendors.FIRSTAID = {
    { skill = 180, recipe = "Heavy Silk Bandage", item = "Manual: Heavy Silk Bandage",
      npc = "Deneb Walker", zone = "Arathi Highlands", x = 26.97, y = 58.83, note = "Stromgarde Keep (same vendor as Expert First Aid)" },
    { skill = 210, recipe = "Mageweave Bandage", item = "Manual: Mageweave Bandage",
      npc = "Deneb Walker", zone = "Arathi Highlands", x = 26.97, y = 58.83, note = "Stromgarde Keep" },
    { skill = 155, recipe = "Greater Healing Potion", item = "Manual: Greater Healing Potion", kind = "drop",
      npc = "Syndicate Mercenary", note = "drops from Syndicate Mercenaries" },
    { skill = 215, recipe = "Superior Healing Potion", item = "Manual: Superior Healing Potion", kind = "drop",
      npc = "Gordunni Shaman", zone = "Feralas", note = "drops from Gordunni Shamans" },
    { skill = 275, recipe = "Major Healing Potion", item = "Manual: Major Healing Potion", kind = "vendor",
      npc = "Pexmit", note = "or quest 'A Rest Without Pain'" },
}
