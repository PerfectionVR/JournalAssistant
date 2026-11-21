# Journal Assistant (JA)

A progression planner for **World of Warcraft: Forever**: professions, class quests, library books
and camping in one dashboard, with an optional waypoint arrow. It needs no other addons; it uses
**TomTom** (arrow) and **Auctionator** (price estimates) when they are installed.

- [Install](#install) · [First run](#first-run) · [Using it](#using-it) · [Commands](#commands)
- [Professions](#professions) · [Class quests](#class-quests) · [Library books](#library-books) · [Camping](#camping)
- [Navigation](#navigation) · [Prices](#price-estimates) · [Safety](#safety) · [Data sources](#data-sources)
- [Known limitations](#known-limitations) · [Development](#development) · [License](#license)

---

## Install

1. Download `JournalAssistant-<version>.zip` from the
   [Releases page](https://github.com/PerfectionVR/JournalAssistant/releases) (or build it, see [Build](#build)).
2. Extract it so the `.toc` file ends up at
   `World of Warcraft\_forever_\Interface\AddOns\JournalAssistant\JournalAssistant.toc`.
3. Enable **Journal Assistant** in the character screen's AddOns list. If it is marked
   *out of date*, tick "Load out of date AddOns" and report the output of `/ja debug`.

## First run

1. `/ja` opens the dashboard.
2. **Open each crafting profession window once** (Alchemy, Cooking, First Aid, ...). JA reads your real
   recipes, their colours and reagents from the client; until then the plan says "Open your X window once".
3. Re-open a window every 10-15 skill points: recipe colours can only be read while the window is open.
   In between JA estimates the colours and says so.

## Using it

The dashboard has a **Next objective** box (the active task, its progress, Navigate / Done / Skip /
Next / Mark / Arrow) and a tab row:

| Tab | Shows |
|---|---|
| **Plan** (default) | Your route: what to do now, in travel order. Then *Requirements not met yet*, *Skipped* and a collapsible *Completed*. **Filter** cycles through the categories in the plan, **Route on/off** switches between travel order and pure priority. |
| **Professions** | One row per profession. The **On/Off** switch under the icon pauses a profession (no tasks, its materials are bought instead of gathered). Click a row for rank, recipes, target (`-` / `+`) and priority (Normal / High / Low). |
| **Class** | Your class quest chains. |
| **Books** | Library books, the turn-in task and the next milestone (`turned in / total`). |
| **Camping** | The Cozy Sleeping Bag chain and your next camp objects. |

**Plan rows:** tick the box to complete a task by hand (it comes back if the planner still needs it after
you gain skill); **Go** navigates; **Skip** hides it (undo in *Skipped*). Hover for details, materials,
cost and why it was planned.

**Guide tabs (Class, Books, Camping):** every row has an **On/Off** switch. **On** puts it into the Plan:
a quest chain adds its current step (routed with your other tasks and made active, so the arrow points at
it) and its later steps under *Requirements not met yet*. **Off** removes it from the Plan; it stays listed
on its tab. Right-click a row to mark it done by hand. Finished entries move to a collapsible
**COMPLETED** section; right-click one there to put it back if it is not really done.

The **tracker** is a small separate frame with the active task (left-click: dashboard, right-click: next
task, drag to move). **Compact** mode shows only the Next objective box.

## Commands

| Command | What it does |
|---|---|
| `/ja` | Toggle the dashboard |
| `/ja next` | Make the next task in the route active |
| `/ja route` | Print the route and open the dashboard |
| `/ja arrow` | Quick toggle: the TomTom arrow (or the map pin) follows the active task. Also the **Arrow** buttons, Shift+click on the minimap button and a key binding (Esc > Options > Keybindings > AddOns) |
| `/ja nav` | Toggle automatic waypoint navigation |
| `/ja go` | Navigate to the active task now |
| `/ja refresh` | Re-read everything and rebuild the plan |
| `/ja mark` / `/ja mark zone` / `/ja unmark` | Save your position as the active task's destination / as the zone's default spot / forget it |
| `/ja target <profession> <value>` | Set a target, e.g. `/ja target alchemy 300` |
| `/ja pause <profession>` | Switch a profession off / on |
| `/ja plan`, `professions`, `class`, `books`, `camping` | Open that tab |
| `/ja compact`, `tracker`, `minimap`, `config`, `reset` | Compact view, tracker, minimap button, settings, reset window position |
| `/ja debug` | Diagnostics window (Ctrl+A, Ctrl+C to copy) |

`/journal` works the same as `/ja`.

## Professions

Every relevant event (skill-up, bags, zone change, profession / trainer window, level-up, quest
turn-in) rebuilds the plan, throttled to 0.4 s. There is no polling.

1. **Ranks.** If your cap (from the client) is below your target, JA adds the trainer, book or quest that
   raises it. Tradeable unlock books whose vendor stands in a dangerous area become Auction House tasks.
2. **Crafting steps.** For each crafting profession JA commits to one recipe for one **step**, e.g.
   *Craft ~44 x Curiously Tasty Omelet (Cooking 150 -> 175)*:
   - The recipe is the learned one with the best expected skill per craft, preferring the **Forever guide
     recipe** for your skill and materials you already own. A learned guide recipe always wins over an
     off-guide one; crafts you can still make from your bags with the off-guide recipe are mentioned.
   - A step ends where the guide moves to the next recipe. Past its guide range a recipe only gets short
     10-point steps.
   - The number of crafts is estimated once, when the step starts (orange 1 skill/craft, yellow ~0.6,
     green ~0.3), so you get **one shopping list for the whole step**: buy it all at once.
   - **One focused step at a time:** only the focused step's materials become gather / buy tasks. Other
     steps wait as *Queued*; click one to focus it instead.
3. **Better recipes.** Guide recipes you do not know yet are suggested with where to get them: trainers you
   visited, Wowhead Forever "Taught by" / "Sold by" / "Dropped by" data, the client's source text.
4. **Herbalism / Mining.** The best zone that is safe for your level, scored by nodes that still give skill,
   nodes your crafting needs, the guide route for your skill, other tasks in the same zone and travel cost.
5. **Skinning / Fishing.** The guide zone for your skill that is safe for your level; fishing prefers zones
   you already visit and fish Cooking needs.
6. **Obtain.** Material demand nothing else covers becomes a vendor or Auction House task.

**Level gates:** when the guide zone for your skill is above your level, a *Reach level X* entry lists
what to do instead (slower safe zone, materials to buy, tasks in other professions).

## Class quests

Your class's quest chains appear on the **Class** tab as soon as your level allows (up to 4 levels ahead
under *Later*). A chain only appears if it fits your **faction and race**, and it waits for its
**prerequisite** ("Finish "Fire Hardened Mail" first") - both from Wowhead Forever's quest pages.

Every step knows who gives it, who takes it and what it asks for (`Data/Classes/<Class>.lua`):
- not picked up yet: the task points at the quest giver;
- in your quest log: one task per open objective (item or kill), pointing at where it drops or spawns,
  with the mob's level as a safety floor. Progress comes from your quest log (kills too), else your bags;
- all objectives done: *turn in to <NPC>* becomes active and points at that NPC.

Progress is detected from the reward spell / item, your quest log (a quest in your log is never counted
as turned in), the server's completed-quest flags and turn-ins JA recorded.

| Class | Coverage |
|---|---|
| Warrior | Defensive Stance (Human, Dwarf/Gnome, Night Elf), L20 shield, L28 Fire Hardened armour and its race-specific follow-ups, L30 Berserker Stance, Whirlwind weapon. Skyborne / Horde stance quests by name only. |
| Mage | L10 per race, L15 robe, L26 robe, L38 wand, both factions. |
| Hunter | Taming quests per race. |
| Rogue | Lockpicking and poisons, both factions. |
| Druid | Bear, Moonglade, Cure Poison, Aquatic and Cat Form. |
| Shaman | Dwarf totem quests; Horde totem quests by name and reward spell. |
| Paladin | Moonsilver Blade chain, Tome of Valor; Redemption and charger by name and reward spell. |
| Warlock | Pets and mounts, detected by the summon spell you learn. |
| Priest | No Forever class quests found in any guide. |

## Library books

All 39 known Forever library books, with coordinates and directions; safe ones first, others gated
*Reach level X*. Books in your bags become *Turn in N books to Garion Wendell* (Stormwind) / Owen Thadd
(Undercity). Turn-ins are detected automatically; right-click a book you turned in before installing JA.
Milestone rewards at 10, 20 (level 20), 25 (level 35) and 35 books (level 50).

## Camping

- **Cozy Sleeping Bag** chain from level 14: every step starts at a world object, so the task points at
  the current step (Westfall / Barrens -> Stonetalon -> Loch Modan -> Hillsbrad).
- **Camp objects:** the next one per profession. Tier 1 from "Camping 101" or your trainer, tiers 2 and 3
  are dungeon blueprints, gated by the dungeon's level.

## Navigation

- **Arrow** (`/ja arrow`): TomTom's arrow, or the game's map pin without TomTom, always points at the
  active task. Turning it off removes only JA's waypoint.
- **Automatic navigation** (`/ja nav`, off by default) sets a waypoint when the active task changes.
- JA only ever removes waypoints it created. It never replaces a map pin set by you or another addon
  (Questie, ...) unless you press Navigate or enable *Allow auto-navigation to replace other waypoints*.
- Destinations: locations you saved with `/ja mark` first, then bundled coordinates (Wowhead / guides,
  marked `~` when approximate), then the zone itself ("Travel to ...").
- The tracker and dashboard always show zone and coordinates, plus distance and direction on the same map.

## Price estimates

With **Auctionator** loaded, every task that asks you to buy or gather something shows the estimated cost
of what is still missing (`~1g 70s`); the tooltip lists each item with its source and age. The vendor price
is used when cheaper. Without data JA says "no AH price yet" / "no price data" - it never invents a price.

## Safety

A zone or area whose lowest mob level is above yours is never planned (*Reach level X*) unless you enable
*Allow dangerous zones*; areas close to your level are marked with a caution.

## Data sources

| Data | Source |
|---|---|
| Your skills, caps, recipes, colours, reagents, quest log, items | The game client |
| Recipe teachers / vendors / drops, quest objectives, quest givers, drop locations, quest races and prerequisites | Wowhead's **WoW: Forever** database (generated, `Data/Professions/Recipes/`, `Data/Classes/`) |
| Rank unlocks, guide routes and recipes, trainers, books, camping | Forever guides, Nov 2026: Wowhead, Method, wow-professions, Timesaver, Warcraft Tavern, ConquestCapped |
| Herb / ore skill levels | Timesaver (verified unchanged from Classic) |
| Zone level ranges, travel links, some trainer names | Classic 1.12 (marked "Classic data, unverified") |

## Known limitations

- Recipe colours are exact only right after you open the profession window.
- Objectives without a Wowhead location (items an NPC hands you, crafted items, "use X at a spot") point
  at the quest's NPCs; objectives inside a dungeon point at the dungeon's zone.
- Follow The Arrow integration is indirect (it follows the shared map pin; it has no public API).
- JA reads no data from other addons; `/ja debug` only detects them.

---

## Development

### Layout

Generic, reusable code is separate from profession- and class-specific code. Each folder has one job and
no file is large; module-specific code plugs into the generic parts through small registries.

```
JournalAssistant.toc   load order (the build reads it), SavedVariables JA_DB / JA_CharDB
Init.lua                          bootstrap: saved variables, login, generic events, public API

Core/            generic, no profession or quest knowledge
  Core.lua         namespace, utilities, saved-variable defaults (RegisterDefaults), event + message bus,
                   throttled refresh, categories (RegisterCategory), priorities
  Inventory.lua    item counts (bags + bank), item IDs learned at runtime
  Prices.lua       Auctionator price lookups
  Routes.lua       map-ID resolution, level safety, travel cost, destinations, route ordering
  Navigation.lua   TomTom / map pin / text guidance with waypoint ownership
  Diagnostics.lua  /ja debug report (AddSection)
  Commands.lua     /ja dispatcher (AddCommand) and the generic commands

Planner/         generic task engine
  Planner.lua      Build(): sources -> evaluation -> state -> route; helpers in PL.util
  Actions.lua      select / next / skip / done / On-Off

UI/              generic UI
  Theme.lua        colours, fonts, widgets
  Dashboard.lua    frame, Next objective box, tab registry (AddTab), row pools (Pool)
  TaskRows.lua     task row + tooltip, shared by all tabs and the tracker
  PlanTab.lua      the Plan tab
  GroupTabs.lua    guide-group tabs with On/Off rows (AddGroupTab)
  Tracker.lua, Minimap.lua, Settings.lua (AddCheck / AddCycle)

Professions/     everything profession-specific
  Professions.lua  detection, targets, pausing, /ja target|pause
  Recipes.lua      profession-window scans          Trainers.lua   trainer-window scans
  Helpers.lua      node colours, item -> node / fish, guide band bonus
  Ranks.lua, BetterRecipes.lua, Crafting.lua, Gathering.lua, Skinning.lua, Fishing.lua, Obtain.lua
                   one task source each
  Plan.lua         plugs the sources, skill metrics and objectives into the planner
  Tab.lua          the Professions tab

Guides/          class quests, library books, camping
  QuestChains.lua  chain progress, quest log, objectives, prerequisites, races (generic chains)
  ChainTasks.lua   chain -> tasks (tab rows; steps / objectives when switched On)
  ClassQuests.lua  class-specific: which chains are yours
  Books.lua, BookTasks.lua, Camping.lua
  Plan.lua         plugs the guides into the planner, settings and tabs

Data/            static data, one file per profession / class
  World.lua                  zones, travel links, hubs, dungeons
  Professions/Common.lua     shared tables and helpers (ranks, route bands, guide steps)
  Professions/<Name>.lua     metadata, trainers, ranks, guide route / recipes, vendors, tips (+ herbs, ores, fish)
  Professions/Recipes/<Name>.lua   generated: Wowhead Forever recipe teachers / vendors / drops
  Classes/Common.lua         chain field reference, quest-detail format
  Classes/<Class>.lua        the class's chains + generated Wowhead quest details
  Guides/Books.lua, Guides/Camping.lua

tests/           not shipped: mocked WoW API, scenario tests, Lua syntax check
build.ps1        checks, packages dist/<Name>-<version>.zip, optional install
```

### How the planner fits together

`Planner/Planner.lua` knows nothing about professions or quests. Modules register:

| Hook | Used for |
|---|---|
| `PL:AddSource(order, name, fn(ctx))` | adding tasks (`PL.util.AddTask`), material demand (`AddDemand`) |
| `PL:AddStage("prepare" \| "linked" \| "finish", fn)` | context setup, cross-task links, summaries (e.g. per-profession objective) |
| `PL:AddMetric(fn(t, m, ctx))` | progress / completion from a task's `metric` (skill goal, quest objective, ...) |
| `PL:AddTaskPrepare(fn)`, `PL:AddProgressMark(fn)` | per-task bookkeeping; when a manual "done" expires |
| `PL:AddDoneHandler(fn(t, done))` | side effects of ticking a task (book turned in, quest step turned in) |
| `UI:AddTab`, `UI:AddGroupTab`, `ns.Settings:AddCheck`, `ns:AddCommand`, `ns.Diagnostics:AddSection`, `ns:RegisterDefaults`, `ns:RegisterCategory` | UI, options, commands, diagnostics, saved settings |

A task is a table: `id`, `title`, `detail`, `kind`, `prof` (category key), `zone`/`dest`, `blocked`,
`caution`, `value`, `metric`, `materials`, and for guide tabs `group` (+ `expands` when its steps are added
separately once switched On).

### Adding data

- **A profession:** add `Data/Professions/<Name>.lua` (copy an existing one: `D.AddProfession`, trainers,
  ranks, guide recipes) and list it in the `.toc`. Detection, the tab and the planner pick it up.
- **A class:** add chains to `Data/Classes/<Class>.lua`. Chain fields are documented in
  `Data/Classes/Common.lua`; quest details go into `D.questInfo[id]` with `start`, `finish`, `obj`,
  `races` (race IDs) and `requires` (`{ { questID, "name" } }`).
- **A new guide group:** a source with `PL:AddSource`, tasks with `group = "<KEY>"`, and `UI:AddGroupTab`.

Data must come from a source (Forever guides or Wowhead's `/forever/` pages); note the source in the
file header. Nothing is guessed.

### Tests

```
npm install --prefix tests      # once: luaparse for the syntax check
pip install lupa                 # once: Lua 5.1 runtime for the scenario tests
node tests/syntax_check.js       # Lua 5.1 syntax of every file
python tests/run.py              # loads the addon in TOC order against tests/mock.lua and runs the scenarios
```

### Build

```
.\build.ps1                      # checks + dist\<Name>-<version>.zip
.\build.ps1 -Install             # also installs into World of Warcraft\_forever_\Interface\AddOns
.\build.ps1 -Install -WowPath "D:\Games\World of Warcraft\_forever_"
.\build.ps1 -SkipChecks          # package only
```

The addon name is the `.toc` file's name. The TOC's version is the packager token `@project-version@`;
the local build replaces it with `git describe` (or `dev`). Only files the TOC loads plus the TOC,
`Bindings.xml`, this README, `LICENSE` and `CHANGELOG.md` are packaged.

Ace3 is not used: the addon only needs events, frames and SavedVariables, which keeps it free of
dependencies and load-order risk on a new client.

### Branches and releases

Git flow, as in RPSheet:

- `main` holds released versions only; every release is a `vX.Y.Z` tag on it.
- `develop` is where finished work collects. New work goes on `feature/<name>` from `develop`
  and is merged back with a pull request; the **Tests** workflow runs on every push and pull request.
- A release: `release/X.Y.Z` from `develop`, put the notes under `## X.Y.Z` in `CHANGELOG.md`,
  merge into `main`, tag `vX.Y.Z`, merge back into `develop`. Urgent fixes: `hotfix/X.Y.Z` from `main`.
- Pushing the tag runs the **Release** workflow: the BigWigs packager (`.pkgmeta`) builds
  `JournalAssistant-vX.Y.Z.zip` and publishes it as a GitHub release with the changelog.
  A tag containing `alpha` or `beta` becomes a pre-release. *Run workflow* on the Actions page makes a
  test build without publishing.

### Renamed from Forever Profession Assistant

Until 0.1.0 the addon was called *Forever Profession Assistant* (`/fpa`, saved variables `FPA_DB` /
`FPA_CharDB`). The game keeps saved variables per addon folder, so old settings do not
carry over by themselves: copy `WTF\Account\<account>\SavedVariables\ForeverProfessionAssistant.lua` to
`JournalAssistant.lua` (and the same under each character's `SavedVariables` folder), replacing `FPA_DB`
with `JA_DB` and `FPA_CharDB` with `JA_CharDB`, while the game is closed.

## License

[MIT](LICENSE). Quest, item and NPC data is collected from Wowhead's World of Warcraft: Forever database and
the Forever guides; it belongs to its respective owners.
