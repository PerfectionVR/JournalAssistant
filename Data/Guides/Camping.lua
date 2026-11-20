-- Journal Assistant - Camping (WoW: Forever)
--
-- Compiled 2026-11-20 from Warcraft Tavern (camping, camp objects, Cozy
-- Sleeping Bag guides) and wow-professions.com (camping guide). Quest IDs of
-- the sleeping bag chain verified on wowhead.com/forever. All chain steps start
-- and end at world OBJECTS (no NPCs); each step carries where to go next.

local _, ns = ...
local D = ns.Data

local function s(id, name, zone, x, y, note) return { id = id, name = name, zone = zone, x = x, y = y, note = note } end

-- Shared tail of the chain (steps 3-6)
local tail = {
    s(79980, "Scramble", "Stonetalon Mountains", nil, nil, "Mound of Dirt on the hillside slightly east of the camp"),
    s(79974, "Wet Job", "Loch Modan", 49, 12, "Stonewrought Dam: jump down to the ledge and click the Carved Figurine"),
    s(79975, "Eagle's Fist", "Hillsbrad Foothills", nil, nil, "Thoradin's Wall, north gap: climb the leaning cart, follow the wall top to the platform, click the Messenger Bag"),
    s(79976, "This Must Be The Place", "Hillsbrad Foothills", nil, nil, "Same platform: click the Hastily Rolled-Up Satchel"),
}
local function chain(first, second)
    local steps = { first, second }
    for _, t in ipairs(tail) do steps[#steps + 1] = t end
    return steps
end

D.campingChains = {
    { key = "bagA", level = 14, faction = "Alliance",
      title = "Cozy Sleeping Bag", reward = "Cozy Sleeping Bag (rested area, +XP), Old Toolbox, Student Fodder, weapon choice",
      item = 211527,
      steps = chain(
          s(79008, "...and that note you found", "Westfall", 37, 50, "Nailed Plank at Alexston Farmstead; turn in at the Burned-Out Remains, southern Barrens (46, 74)"),
          s(79192, "Stepping Stones", "The Barrens", 46, 74, "From the Burned-Out Remains go to the Pocket Litter at a hill camp near Sun Rock Retreat, Stonetalon")),
      start = { zone = "Westfall", x = 37, y = 50, note = "Nailed Plank, Alexston Farmstead" },
      zones = { "Westfall", "The Barrens", "Stonetalon Mountains", "Loch Modan", "Hillsbrad Foothills" },
      note = "Pocket Litter also gives Flint and Tinder + Simple Wood: light the campfire there (optional 'Rekindle').",
      confidence = "forever-guide" },
    { key = "bagH", level = 14, faction = "Horde",
      title = "Cozy Sleeping Bag", reward = "Cozy Sleeping Bag (rested area, +XP), Old Toolbox, Student Fodder, weapon choice",
      item = 211527,
      steps = chain(
          s(79007, "...and that note you found", "The Barrens", 46, 74, "Burned-Out Remains, southern Barrens; turn in at the Nailed Plank, Westfall (37, 50)"),
          s(79192, "Stepping Stones", "Westfall", 37, 50, "From the Nailed Plank go to the Pocket Litter at a hill camp near Sun Rock Retreat, Stonetalon")),
      start = { zone = "The Barrens", x = 46, y = 74, note = "Burned-Out Remains" },
      zones = { "The Barrens", "Westfall", "Stonetalon Mountains", "Loch Modan", "Hillsbrad Foothills" },
      note = "Stonewrought Dam (Loch Modan) has level 30 Alliance guards - the hardest step for Horde.",
      confidence = "forever-guide" },
}

-- Camp objects per profession: tier 1 (skill 20) from "Camping 101: <Profession>"
-- or the trainer; tiers 2-3 need a blueprint that drops from a dungeon boss.
local function o(skill, name, effect, boss, dungeon) return { skill = skill, name = name, effect = effect, boss = boss, dungeon = dungeon } end
D.campObjects = {
    ALCHEMY = { o(20, "Mana Well", "mana regeneration"), o(140, "Fermenter", "workstation", "Rath'mael", "Ruins of Lordaeron"),
                o(300, "Alchemy Laboratory", "workstation", "Ras Frostwhisper", "Scholomance") },
    BLACKSMITHING = { o(20, "Sharpening Wheel", "Strength"), o(140, "Anvil", "anvil", "Gilnid", "The Deadmines"),
                      o(300, "Master Forge", "workstation", "Golem Lord Argelmach", "Blackrock Depths") },
    COOKING = { o(1, "Basic Campfire", "campfire for 3 camp objects (Simple Wood + Flint and Tinder)"),
                o(140, "Journeyman Campfire", "campfire for 5 objects (Star Wood); guides say skill 90-140", "Lord Serpentis", "Wailing Caverns"),
                o(140, "Cookie's Feast", "Stamina food for the camp", "Cookie", "The Deadmines"),
                o(220, "Expert Campfire", "campfire for 10 objects (Thick Logs); drop source unconfirmed"),
                o(300, "Iron Oven", "workstation", "Quartermaster Zigris", "Lower Blackrock Spire") },
    ENCHANTING = { o(20, "Enchanted Lute", "stats and resistances"), o(140, "Arcane Salvager", "better disenchanting", "Shade of the Archmage", "Dalaran"),
                   o(300, "Arcane Forge", "workstation") },
    ENGINEERING = { o(20, "Reagent Bot", "reagent vendor"), o(140, "Repair Bot", "repairs", "Sneed", "The Deadmines"),
                    o(300, "Anarchist's Workbench", "workstation", "Ezra Grimm", "Stratholme") },
    FIRSTAID = { o(20, "First Aid Kit", "Stamina"), o(140, "Toxin Study", "healing potions, anti-venom", "Commander Springvale", "Shadowfang Keep"),
                 o(300, "Plague Doctor's Laboratory", "healing potions, poultices", "Doctor Theolen Krastinov", "Scholomance") },
    FISHING = { o(20, "Fish Bowl", "+8% all stats"), o(140, "Fishing Rack", "uncommon fish for 1 hour, lures", "Gelihast", "Blackfathom Deeps"),
                o(300, "Fishing Hut", "rare fish for 1 hour, lures", "Jammal'an the Prophet", "Sunken Temple") },
    HERBALISM = { o(20, "Incense Candle", "Intellect"), o(140, "Greenhouse", "grows herbs from seeds", "Shadetooth", "Excavation Site: Wetlands"),
                  o(300, "Seed Hybridizer", "multiplies / converts seeds", "Tendris Warpwood (unconfirmed)", "Dire Maul") },
    LEATHERWORKING = { o(20, "Camp Tent", "rested XP up to 5% of a level, once an hour"), o(125, "Tanning Rack", "needed for some materials", "Razorclaw the Butcher", "Shadowfang Keep"),
                       o(300, "Sewing Machine", "workstation", "Vectus", "Scholomance") },
    MINING = { o(20, "Lodestone", "attack power"), o(140, "Rock Garden", "spawns a mining node", "Relic Guardian", "Excavation Site: Wetlands"),
               o(300, "Molten Foundry", "smelting Heavy Thorium", "Ambassador Flamelash", "Blackrock Depths") },
    SKINNING = { o(20, "Camp Chair", "+2% crit"), o(140, "Field Guide", "track beasts", "Lady Anacondra", "Wailing Caverns"),
                 o(300, "Trapper's Workbench", "workbench with a trap", "The Beast", "Upper Blackrock Spire") },
    TAILORING = { o(20, "Faction Banner", "Spirit"), o(140, "Spinning Wheel", "workstation", "Unstable Sentinel", "Dalaran"),
                  o(300, "Loom", "workstation", "Baroness Anastari", "Stratholme") },
}

D.campingTips = "Sit (/sit) at a campsite for 1 minute to get the buffs. Each player can place one camp object per hour; campfires hold 3 / 5 / 10 objects by tier."
