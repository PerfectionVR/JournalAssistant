-- Journal Assistant - Skinning data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Skinning. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("SKINNING", { name = "Skinning", skillLine = 393, kind = "gather", order = 3,
    icon = "Interface\\Icons\\INV_Misc_Pelt_Wolf_01" })

D.trainers.SKINNING = {
    src("Maris Granger", "Stormwind City", "Alliance", 72.2, 62.5, { note = "Old Town" }),
    src("Balthus Stoneflayer", "Ironforge", "Alliance", 39.7, 32.3, { note = "The Great Forge" }),
    src("Helene Peltskinner", "Elwynn Forest", "Alliance", 46.3, 62.3, { note = "Goldshire" }),
    src("Wilma Ranthal", "Redridge Mountains", "Alliance", 83.6, 71.2),
    src("Jayla", "Ashenvale", "Alliance", 49.9, 67.2, { note = "Silverwind Refuge" }),
    src("Thuwd", "Orgrimmar", "Horde"),
}

D.ranks.SKINNING = standard("SKINNING", { noLevel = true })

D.routeBands.SKINNING = {
    { from = 1,   to = 75,  zones = { "Elwynn Forest", "Dun Morogh", "Teldrassil" }, note = "Any beasts" },
    { from = 75,  to = 130, zones = { "Loch Modan" }, note = "Elder Mountain Boar, Black Bear Patriarch (lvl 16-17)" },
    { from = 130, to = 150, zones = { "Wetlands" }, note = "Mottled Scytheclaw / Razormaw at Whelgar's Excavation (lvl 25-27)" },
    { from = 150, to = 160, zones = { "Hillsbrad Foothills" }, note = "Bears and lions outside Foothill Caverns (lvl 22-24)" },
    { from = 160, to = 225, zones = { "Hillsbrad Foothills", "Duskwood", "Stranglethorn Vale" },
      note = "Foothill Caverns yetis (lvl 30-32) or Nightbane worgs in Duskwood (lvl 26-29)" },
    { from = 225, to = 280, zones = { "Feralas" }, note = "Feral Scar Vale yetis (lvl 43-46)" },
    { from = 280, to = 300, zones = { "Un'Goro Crater" }, note = "Dinosaurs in western Un'Goro (lvl 50-55)" },
}

D.tips.SKINNING = "You can skin a beast up to level skill/5 (for mobs above level 20); orange/yellow corpses give skill."
