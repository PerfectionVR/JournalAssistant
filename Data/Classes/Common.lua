-- Journal Assistant - Shared class quest data helpers
--
-- Loaded before the per-class files (Data/Classes/<Class>.lua).
--
-- Chains were compiled 2026-11-20. Quest IDs were verified one by one on
-- Wowhead's WoW: Forever database (wowhead.com/forever/quest=ID); levels are
-- Wowhead's. Chain order follows Wowhead's "Series" lists; start NPCs from
-- Wowhead / Warcraft Tavern / Method Forever guides. Steps without an ID are
-- tracked by quest name (learned when you turn them in) and, where possible,
-- by the reward spell you learn (spell IDs from the guides).
--
-- Chain fields:
--   level     minimum character level          faction  "Alliance"/"Horde"/nil
--   races     list of race tokens (nil = all)  reward   text
--   spell     reward spell ID: knowing it marks the chain complete
--   steps     { { id = questID?, name = "Quest title", objectives? }, ... } in order
--   start     { npc, zone, x, y, note }        zones    zones the chain visits
--   area      { min = level, name } dangerous spot (gates the chain)
--   after     key of a chain that must be finished first
--   optional  true = nice-to-have (lower priority)
--   confidence "forever-guide" (IDs verified) | "unverified"
--
-- Quest details (D.questInfo[questID], generated 2026-11-20 from Wowhead's
-- WoW: Forever database):
--   wowhead.com/forever/quest=ID   -> objectives table, start / end NPC and
--                                     the quest map (objective + drop points)
--   wowhead.com/forever/item=ID    -> dropped-by / contained-in-object lists
--                                     (mob level ranges) when the quest map had
--                                     no drop points
--   wowhead.com/forever/npc|object -> map data (average spawn position)
-- Fields: start / finish = { npc, zone, x, y }; obj = list of
--   { item | kill | object = id, name, qty, from, zone | area (area ID, resolved
--     in game), x, y, mapID, areaMin (level of the dropping mob) }
-- Objectives without a location are items the quest giver hands you, crafted
-- items or "use X at a spot" steps: the planner then points at the quest NPCs.

local _, ns = ...
local D = ns.Data

D.classQuests = {} -- [CLASS TOKEN] = { chain, ... }
D.questInfo = {}   -- [questID] = { start, finish, obj }

function D.QuestStep(id, name) return { id = id, name = name } end
function D.NamedStep(name) return { name = name } end
