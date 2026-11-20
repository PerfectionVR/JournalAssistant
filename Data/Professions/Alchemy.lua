-- Journal Assistant - Alchemy data
-- Trainers, rank unlocks, Forever guide route / recipes,
-- recipe vendors and tips for Alchemy. Shared helpers: Data/Professions/Common.lua.

local _, ns = ...
local D = ns.Data
local src, standard = D.TrainerSource, D.StandardRanks

D.AddProfession("ALCHEMY", { name = "Alchemy", skillLine = 171, kind = "craft", order = 4,
    icon = "Interface\\Icons\\Trade_Alchemy" })

D.trainers.ALCHEMY = {
    src("Lilyssia Nightbreeze", "Stormwind City", "Alliance", nil, nil, { note = "Mage Quarter" }),
    src("Tally Berryfizz", "Ironforge", "Alliance", nil, nil, { note = "Tinker Town" }),
    src("Ghak Healtouch", "Loch Modan", "Alliance", nil, nil, { note = "Thelsamar" }),
    src("Ainethil", "Darnassus", "Alliance", 55.0, 23.4, { note = "Craftsmen's Terrace (Expert)" }),
    src("Yelmak", "Orgrimmar", "Horde"),
}

D.ranks.ALCHEMY = standard("ALCHEMY", {
    artisan = { src("Kylanna Windwhisper", "Feralas", "Alliance", 32.4, 43.8, { note = "Feathermoon Stronghold" }),
                src("Rogvar", "Swamp of Sorrows", "Horde", 48.2, 55.4, { note = "Stonard" }) },
    artisanNote = "Guides disagree whether Artisan needs skill 200 or 225." })

D.guideRecipes.ALCHEMY = {
    { 1, 12, "Elixir of Minor Force" }, { 12, 55, "Elixir of Minor Defense" }, { 55, 65, "Minor Mana Potion" },
    { 65, 90, "Elixir of Minor Fortitude" }, { 90, 120, "Elixir of Wisdom" }, { 120, 160, "Lesser Mana Potion" },
    { 160, 195, "Mana Potion" }, { 195, 205, "Elixir of Agility" }, { 205, 240, "Greater Mana Potion" },
    { 225, 226, "Philosopher's Stone" }, { 240, 260, "Draught of Detect Undead" }, { 240, 260, "Elixir of Detect Undead" },
    { 260, 270, "Superior Mana Potion" }, { 270, 300, "Major Discolored Healing Potion" },
}

D.recipeVendors.ALCHEMY = {
    { skill = 225, recipe = "Philosopher's Stone", item = "Recipe: Philosopher's Stone",
      npc = "Alchemist Pestlezugg", zone = "Tanaris", note = "Gadgetzan" },
    { skill = 260, recipe = "Superior Mana Potion", item = "Recipe: Superior Mana Potion",
      npc = "Ulthir", zone = "Darnassus" },
}
