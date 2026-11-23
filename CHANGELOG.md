# Changelog

## 0.2.0 - final release

Journal Assistant is no longer maintained: the Polestar addon covers the same ground.
This last release collects the remaining work.

- Class quests: every lead-in and follow-up from Wowhead Forever's quest series for
  Warrior, Warlock, Shaman, Paladin, Druid, Hunter, Mage and Rogue, per race where the
  races start in different places (for example Cyclonian's lead-in for Warriors, the
  full Dreadsteed and Charger chains, Bear Form, The Hunter's Path, Mage's Wand and
  The Touch of Zanzil). Quests that open while another one is in your log say
  "Accept ... first", and a lead-in offered by two quest givers counts either way.
- A quest only counts as in your log by its own quest ID, so chains that repeat a title
  (The Tome of Divinity, Call of Water) no longer lose their progress.
- Recipes in your bags wait for the skill the recipe item needs (Manual: Mageweave
  Bandage asked for First Aid 150 instead of 210), and for the character level the
  recipe item itself needs. The level of what it makes does not hold it back.

## 0.1.0

First public release, renamed from Forever Profession Assistant to Journal Assistant.

- Professions: skill-up plan per profession (training ranks, crafting with the guide's
  recipes, gathering, skinning, fishing, buying or farming materials), each switched
  On/Off under its icon, with targets and price estimates.
  A recipe you bought says to use it from your bags, and a learned recipe drops out
  of the plan straight away (checked by spell, also when the guide names it differently).
- Class quests for every class, as steps in the plan when switched on. Quests check
  your race and the quests they need first (from Wowhead Forever), so locked follow-ups
  show "Finish ... first" and quests for other races are hidden.
  Objectives of a quest you already have are never hidden for level: a higher-level
  target (like Gutspill for the Burning Rock) shows a caution instead.
- Library books and camping as their own tabs; skipped chains go back under Later and
  finished ones under Completed.
- Waypoints through TomTom or map pins, a tracker, a minimap button and key bindings.
- Commands are now `/ja` (also `/journal`).
