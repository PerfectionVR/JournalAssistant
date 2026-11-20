-- Journal Assistant - Fishing data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Fishing. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("FISHING", { name = "Fishing", skillLine = 356, kind = "fish", order = 11,
    icon = "Interface\\Icons\\Trade_Fishing" })

D.trainers.FISHING = {
    src("Arnold Leland", "Stormwind City", "Alliance", 55.0, 69.6),
    src("Grimnur Stonebrand", "Ironforge", "Alliance", 48.4, 6.4),
    src("Lee Brown", "Elwynn Forest", "Alliance", 47.6, 62.2, { note = "Goldshire" }),
    src("Harold Riggs", "Wetlands", "Alliance", 8.2, 58.6, { note = "Menethil Harbor" }),
    src("Lumak", "Orgrimmar", "Horde"),
}

D.ranks.FISHING = {
    { rank = "Journeyman", fromCap = 75, cap = 150, reqSkill = 50, minLevel = 10, method = "trainer",
      sources = D.trainers.FISHING, confidence = "forever-guide" },
    { rank = "Expert", fromCap = 150, cap = 225, reqSkill = 125, minLevel = 20, method = "book",
      item = "Expert Fishing - The Bass and You", itemID = 16083, tradeable = true,
      sources = { src("Old Man Heming", "Stranglethorn Vale", nil, 27.4, 77.0,
          { note = "bottom of the Booty Bay docks, 1 gold", area = { min = 30, name = "the road through Stranglethorn" } }) },
      confidence = "forever-guide",
      note = "Tradeable - also on the Auction House. Buy Bright Baubles from him while there." },
    { rank = "Artisan", fromCap = 225, cap = 300, reqSkill = 225, minLevel = 35, method = "quest",
      item = "Nat Pagle, Angler Extreme (quest)",
      sources = { src("Nat Pagle", "Dustwallow Marsh", nil, 58.6, 60.0, { note = "Tidefury Cove" }) },
      confidence = "forever-guide",
      note = "Catch 4 quest fish in Feralas, Swamp of Sorrows, Desolace and Stranglethorn." },
}

D.routeBands.FISHING = {
    { from = 1,   to = 75,  zones = { "Elwynn Forest", "Dun Morogh", "Teldrassil" }, note = "Crystal Lake, east of Goldshire" },
    { from = 75,  to = 130, zones = { "Stormwind City" }, note = "Stormwind canals" },
    { from = 130, to = 205, zones = { "Ashenvale", "Stranglethorn Vale" },
      note = "Mystral Lake (Ashenvale) - keep a lure on from 150",
      spot = { zone = "Ashenvale", x = 49.6, y = 67.0, label = "Mystral Lake" } },
    { from = 205, to = 255, zones = { "Dustwallow Marsh" }, note = "Swamp water, not the ocean (Mithril Head Trout)" },
    { from = 255, to = 300, zones = { "Feralas" }, note = "Lakes near Feathermoon (not Jademir Lake)" },
}

D.tips.FISHING = "From skill 150 keep a lure on (Shiny Bauble +25, Nightcrawlers +50, Bright Baubles +75); skill only rises on successful catches."

-- Fishing: approximate minimum skill to fish a zone's water reliably (Classic).
-- Classic skill gains come from any successful catch, so the zone choice is
-- mostly about safety and combining with other objectives.
D.fishingZones = {
    ["Elwynn Forest"] = 1, ["Dun Morogh"] = 1, ["Teldrassil"] = 1, ["Stormwind City"] = 1, ["Ironforge"] = 1,
    ["Westfall"] = 55, ["Loch Modan"] = 25, ["Darkshore"] = 25,
    ["Redridge Mountains"] = 55, ["Duskwood"] = 55, ["Wetlands"] = 55, ["Ashenvale"] = 55,
    ["Hillsbrad Foothills"] = 55, ["Stonetalon Mountains"] = 55,
    ["Arathi Highlands"] = 130, ["Alterac Mountains"] = 130, ["Desolace"] = 130,
    ["Stranglethorn Vale"] = 130, ["Thousand Needles"] = 130, ["Swamp of Sorrows"] = 130,
    ["Dustwallow Marsh"] = 130, ["Badlands"] = 130,
    ["Tanaris"] = 205, ["Feralas"] = 205, ["The Hinterlands"] = 205, ["Azshara"] = 205,
}

-- Raw fish used by Cooking recipes and where they are commonly caught (Classic).
D.fish = {
    ["Raw Brilliant Smallfish"]       = { "Elwynn Forest", "Dun Morogh", "Teldrassil", "Westfall", "Loch Modan", "Darkshore" },
    ["Raw Longjaw Mud Snapper"]       = { "Stormwind City", "Ashenvale", "Elwynn Forest", "Westfall", "Loch Modan", "Darkshore", "Redridge Mountains" },
    ["Raw Bristle Whisker Catfish"]   = { "Ashenvale", "Stormwind City", "Redridge Mountains", "Duskwood", "Wetlands", "Ashenvale", "Hillsbrad Foothills", "Stonetalon Mountains", "Arathi Highlands" },
    ["Raw Rainbow Fin Albacore"]      = { "Westfall", "Darkshore", "Wetlands" },
    ["Raw Mithril Head Trout"]        = { "Dustwallow Marsh", "Arathi Highlands", "Alterac Mountains", "Stranglethorn Vale", "Swamp of Sorrows", "Desolace", "Badlands" },
    ["Raw Rockscale Cod"]             = { "Stranglethorn Vale", "Desolace", "Dustwallow Marsh", "Arathi Highlands" },
    ["Raw Redgill"]                   = { "The Hinterlands", "Feralas", "Tanaris", "Un'Goro Crater" },
    ["Raw Spotted Yellowtail"]        = { "Tanaris", "Feralas", "Azshara" },
    ["Raw Glossy Mightfish"]          = { "Stranglethorn Vale", "Tanaris", "Feralas" },
}
