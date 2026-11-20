-- Journal Assistant - Warlock class quests
-- Chains (see Data/Classes/Common.lua for the field list) and, below, the
-- generated Wowhead quest details for their steps.

local _, ns = ...
local D = ns.Data
local q, n = D.QuestStep, D.NamedStep

D.classQuests.WARLOCK = { -- quest IDs not available for Forever; completion via the summon spell
    { key = "wl10void", level = 10, faction = "Alliance", races = { "Human" },
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { n("Gakin's Summons") }, start = { zone = "Elwynn Forest", note = "Goldshire warlock trainer" }, confidence = "unverified" },
    { key = "wl10voidg", level = 10, faction = "Alliance", races = { "Gnome" },
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { n("The Slaughtered Lamb") }, start = { zone = "Ironforge" }, confidence = "unverified" },
    { key = "wl10voidh", level = 10, faction = "Horde",
      title = "Summon Voidwalker", reward = "Summon Voidwalker", spell = 697,
      steps = { n("Gan'rul's Summons / Halgar's Summons") }, confidence = "unverified" },
    { key = "wl20succ", level = 20,
      title = "Summon Succubus", reward = "Summon Succubus", spell = 712,
      steps = { n("Devourer of Souls") }, confidence = "unverified",
      note = "From your capital's warlock trainer area." },
    { key = "wl20orb", level = 20, optional = true,
      title = "The Orb of Soran'ruk", reward = "Staff or Orb of Soran'ruk",
      steps = { n("The Orb of Soran'ruk") }, start = { npc = "Doan Karhan", zone = "The Barrens" },
      note = "Needs fragments from Blackfathom Deeps and Shadowfang Keep.", confidence = "unverified" },
    { key = "wl30fel", level = 30,
      title = "Summon Felhunter", reward = "Summon Felhunter", spell = 691,
      steps = { n("Seeking Strahad") }, confidence = "unverified" },
    { key = "wl40steed", level = 40,
      title = "Summon Felsteed (mount)", reward = "Summon Felsteed", spell = 5784,
      steps = { n("Ask your Warlock trainer") }, confidence = "unverified" },
    { key = "wl60dread", level = 60,
      title = "Summon Dreadsteed (epic mount)", reward = "Summon Dreadsteed", spell = 23161,
      steps = { n("Ask your Warlock trainer") }, confidence = "unverified" },
}
