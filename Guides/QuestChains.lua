-- Journal Assistant - Quest chain tracking (generic)
--
-- How far you are in a quest chain (class quests, camping, ...), using in order:
--   1. the reward spell / item (if you have it, the chain is complete)
--   2. your quest log (a quest in your log is never "turned in")
--   3. C_QuestLog.IsQuestFlaggedCompleted(questID) for verified IDs
--   4. quests you turned in (recorded on QUEST_TURNED_IN, so chains without
--      verified IDs still progress)
-- plus where each step starts / ends and its objectives (D.questInfo).
-- Chain lists are registered by the guides that use them (QC:RegisterChains).

local _, ns = ...
local QC = { lists = {} }
ns.QuestChains = QC

local function lower(s) return s and string.lower(s) or nil end

function QC:RaceMatches(chain)
    if not chain.races then return true end
    local name, token = UnitRace("player")
    local a = lower(token or ""):gsub("%s", "")
    local b = lower(name or ""):gsub("%s", "")
    for _, r in ipairs(chain.races) do
        local x = lower(r)
        if x == a or x == b or (x == "scourge" and b == "undead") or (x == "nightelf" and b == "nightelf") then return true end
    end
    return false
end

-- Race restriction of a quest (Wowhead "Race" fact, D.questInfo[id].races = race IDs)
function QC:StepRaceOK(step)
    local info = self:Info(step)
    if not (info and info.races and #info.races > 0) then return true end
    local _, _, raceID = UnitRace("player")
    if not raceID then return true end
    for _, r in ipairs(info.races) do if r == raceID then return true end end
    return false
end

function QC:Applies(chain)
    if chain.faction and chain.faction ~= ns.PlayerFaction() then return false end
    if chain.steps and chain.steps[1] and not self:StepRaceOK(chain.steps[1]) then return false end
    return self:RaceMatches(chain)
end

-- First prerequisite quest of a step that is not done yet (Wowhead "Requires",
-- D.questInfo[id].requires = { { id, name }, ... }; requiresOneOf = any one).
-- requiresActive = Wowhead "Requires In Progress": that quest must be in your
-- log (e.g. Essence of the Exile opens when you accept Cyclonian).
-- Returns { id, name, accept = true when it only has to be accepted } or nil.
function QC:MissingPrereq(step)
    local info = self:Info(step)
    if not info then return nil end
    for _, rq in ipairs(info.requiresActive or {}) do
        local s = { id = rq[1], name = rq[2] }
        if not self:StepInLog(s) and not self:StepDone(s) then
            return { id = rq[1], name = rq[2] or ("quest " .. rq[1]), accept = true }
        end
    end
    for _, rq in ipairs(info.requires or {}) do
        if not self:StepDone({ id = rq[1], name = rq[2] }) then return { id = rq[1], name = rq[2] or ("quest " .. rq[1]) } end
    end
    if info.requiresOneOf and #info.requiresOneOf > 0 then
        for _, rq in ipairs(info.requiresOneOf) do
            if self:StepDone({ id = rq[1], name = rq[2] }) then return nil end
        end
        local rq = info.requiresOneOf[1]
        return { id = rq[1], name = rq[2] or ("quest " .. rq[1]) }
    end
    return nil
end

local function SpellKnown(id)
    if not id then return false end
    if type(IsPlayerSpell) == "function" then
        local ok, v = pcall(IsPlayerSpell, id)
        if ok and v then return true end
    end
    if type(IsSpellKnown) == "function" then
        local ok, v = pcall(IsSpellKnown, id)
        if ok and v then return true end
    end
    return false
end
QC.SpellKnown = SpellKnown

local function QuestCompleted(id)
    if not id then return false end
    if ns.Has("C_QuestLog", "IsQuestFlaggedCompleted") then
        local ok, v = pcall(C_QuestLog.IsQuestFlaggedCompleted, id)
        if ok then return v and true or false end
    end
    if type(IsQuestFlaggedCompleted) == "function" then
        local ok, v = pcall(IsQuestFlaggedCompleted, id)
        if ok then return v and true or false end
    end
    return false
end

-- Titles of quests currently in the log (lower-case) and their IDs
local logCache, logStamp
function QC:QuestLog()
    local now = GetTime and GetTime() or 0
    if logCache and logStamp == now then return logCache end
    local titles, ids = {}, {}
    if ns.Has("C_QuestLog", "GetNumQuestLogEntries") and ns.Has("C_QuestLog", "GetInfo") then
        local okN, n = pcall(C_QuestLog.GetNumQuestLogEntries)
        for i = 1, (okN and n or 0) do
            local ok, info = pcall(C_QuestLog.GetInfo, i)
            if ok and info and not info.isHeader and info.title then
                titles[lower(info.title)] = true
                if info.questID then ids[info.questID] = true end
            end
        end
    elseif type(GetNumQuestLogEntries) == "function" then
        for i = 1, (GetNumQuestLogEntries() or 0) do
            local title, _, _, isHeader, _, _, _, id = GetQuestLogTitle(i)
            if title and not isHeader then
                titles[lower(title)] = true
                if id then ids[id] = true end
            end
        end
    end
    logCache, logStamp = { titles = titles, ids = ids }, now
    return logCache
end

function QC:StepDone(step)
    local done = ns.char.questDone
    -- still in your quest log = not turned in, whatever was recorded before
    -- (clears a stale "turned in" flag, e.g. from a misfired event)
    if self:StepInLog(step) then
        if step.id then done["id:" .. step.id] = nil end
        if step.name then done[lower(step.name)] = nil end
        return false
    end
    if step.id and QuestCompleted(step.id) then return true end
    if step.id and done["id:" .. step.id] then return true end
    -- name-only steps (no verified ID): learned from QUEST_TURNED_IN
    if not step.id and step.name and done[lower(step.name)] then return true end
    return false
end

function QC:StepInLog(step)
    local log = self:QuestLog()
    if step.id and log.ids[step.id] then return true end
    return step.name and log.titles[lower(step.name)] or false
end

-- returns { complete, nDone, total, current = step, inLog }
function QC:State(chain)
    local total = #chain.steps
    if (chain.spell and SpellKnown(chain.spell)) or (chain.item and ns.Inventory:Count({ itemID = chain.item }) > 0) then
        return { complete = true, nDone = total, total = total }
    end
    local nDone, current, inLog = 0, nil, false
    -- a later completed step implies the earlier ones
    local lastDone = 0
    for i, s in ipairs(chain.steps) do
        if self:StepDone(s) then lastDone = i end
    end
    nDone = lastDone
    current = chain.steps[lastDone + 1]
    if current then inLog = self:StepInLog(current) end
    return { complete = lastDone >= total, nDone = nDone, total = total, current = current, inLog = inLog }
end

---------------------------------------------------------------------------
-- Quest details (Data/QuestInfo.lua, generated from Wowhead Forever):
-- where a step starts / ends and what it asks for.
---------------------------------------------------------------------------
function QC:Info(step)
    return step and step.id and ns.Data.questInfo and ns.Data.questInfo[step.id] or nil
end

-- Objectives in a dungeon point at the dungeon's zone (entrance unknown).
local function Normalize(o)
    if o._norm then return o end
    o._norm = true
    -- generated entries may only carry Wowhead's area ID: resolve it in game
    if not o.zone and o.area and ns.Routes and ns.Routes.AreaName then o.zone = ns.Routes:AreaName(o.area) end
    local dg = o.zone and ns.Data.dungeons and ns.Data.dungeons[o.zone]
    if dg then
        o.dungeon, o.zone, o.x, o.y, o.mapID = o.zone, dg.zone, nil, nil, nil
        o.areaMin = o.areaMin or dg.level
    end
    return o
end

-- returns { { o = objective, have = n, done = bool }, ... } or nil.
-- Progress comes from your quest log when the quest is in it (works for
-- kill objectives too), else from the items in your bags.
function QC:Objectives(step)
    if not step then return nil end
    local info = self:Info(step)
    local list = step.objectives or (info and info.obj)
    if not list or #list == 0 then return nil end
    local logObj
    if step.id and ns.Has("C_QuestLog", "GetQuestObjectives") then
        local ok, o = pcall(C_QuestLog.GetQuestObjectives, step.id)
        if ok and type(o) == "table" and #o > 0 then logObj = o end
    end
    local out = {}
    for i, o in ipairs(list) do
        Normalize(o)
        local need = o.qty or 1
        local have, done
        local lo = logObj and logObj[i]
        if lo and (lo.numRequired or 0) > 0 then
            have = lo.numFulfilled or 0
            done = lo.finished or have >= need
            need = lo.numRequired
        elseif lo and lo.finished ~= nil then
            have = lo.finished and need or 0
            done = lo.finished
        elseif o.item then
            have = ns.Inventory:Count({ itemID = o.item, name = o.name })
            done = have >= need
        else
            have, done = 0, false
        end
        out[#out + 1] = { o = o, have = math.min(have, need), need = need, done = done and true or false, index = i }
    end
    return out
end

-- where to pick a step up / turn it in (falls back to the chain start)
function QC:StepStart(chain, step)
    local info = self:Info(step)
    -- several quest givers (e.g. one per capital): the first one of your faction
    if info and info.starts then
        local f = ns.PlayerFaction()
        for _, s in ipairs(info.starts) do
            if not s.faction or s.faction == f then return s end
        end
    end
    return (info and info.start) or (step == chain.steps[1] and chain.start) or nil
end

function QC:StepEnd(chain, step)
    local info = self:Info(step)
    return (info and info.finish) or chain.start or nil
end

-- chain lists (each a list of chains) known to ChainByKey
function QC:RegisterChains(list)
    if list then self.lists[#self.lists + 1] = list end
end

function QC:ChainByKey(key)
    for _, list in ipairs(self.lists) do
        for _, c in ipairs(list) do if c.key == key then return c end end
    end
end

-- Chains of a list that apply to this character (faction / race)
function QC:ChainsFrom(list)
    local out = {}
    for _, chain in ipairs(list or {}) do
        if self:Applies(chain) then out[#out + 1] = chain end
    end
    return out
end

-- QUEST_TURNED_IN: remember the title (and id) so name-only steps progress
function QC:OnTurnedIn(questID)
    if not questID then return end
    ns.char.questDone["id:" .. questID] = true
    local title
    if ns.Has("C_QuestLog", "GetTitleForQuestID") then
        local ok, t = pcall(C_QuestLog.GetTitleForQuestID, questID)
        if ok then title = t end
    end
    if title then ns.char.questDone[lower(title)] = true end
end

-- Remember titles of quests as they are accepted so turn-in can be matched
-- even if the title API is unavailable at turn-in time.
function QC:OnAccepted(...)
    logCache = nil
end

ns:RegisterEvent("QUEST_TURNED_IN", function(_, questID)
    if ns.char then QC:OnTurnedIn(questID) end
    ns:RequestRefresh("quest")
end)
