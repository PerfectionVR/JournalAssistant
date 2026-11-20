-- Journal Assistant - Library book tracking
--
-- A book is: "turned in" (recorded), "in bags" (looted, waiting for the
-- librarian) or "to find". Turn-ins are detected when a QUEST_TURNED_IN
-- happens and a book that was in your bags is gone right after, or when the
-- turned-in quest's title matches a book name. Books you turned in before
-- installing JA can be marked done by hand (right-click the book).

local _, ns = ...
local BK = {}
ns.Books = BK

local snapshot = {}      -- [itemID] = count at last refresh
local pendingTurnIn = 0  -- time of the last QUEST_TURNED_IN

function BK:List()
    local faction = ns.PlayerFaction()
    local out = {}
    for _, b in ipairs(ns.Data.books or {}) do
        if not b.faction or b.faction == faction then out[#out + 1] = b end
    end
    return out
end

function BK:IsTurnedIn(b)
    return ns.char.books[b.item] and true or false
end

function BK:InBags(b)
    return ns.Inventory:Count({ itemID = b.item, name = b.name }) > 0
end

-- Count of turned-in books; milestone quests imply a minimum
function BK:TurnedInCount()
    local n = 0
    for _ in pairs(ns.char.books) do n = n + 1 end
    local implied = 0
    for _, m in ipairs(ns.Data.bookMilestones or {}) do
        local done = false
        if ns.Has("C_QuestLog", "IsQuestFlaggedCompleted") then
            local ok, v = pcall(C_QuestLog.IsQuestFlaggedCompleted, m.quest)
            done = ok and v
        end
        if done and m.books > implied then implied = m.books end
    end
    return math.max(n, implied), n
end

function BK:OnTurnedIn(questID)
    pendingTurnIn = GetTime and GetTime() or 0
    local title
    if questID and ns.Has("C_QuestLog", "GetTitleForQuestID") then
        local ok, t = pcall(C_QuestLog.GetTitleForQuestID, questID)
        if ok then title = t end
    end
    if title then
        local lt = string.lower(title)
        for _, b in ipairs(ns.Data.books or {}) do
            if lt:find(string.lower(b.name), 1, true) then ns.char.books[b.item] = true end
        end
    end
end

-- Called every planner build: detect books that left the bags right after a turn-in
function BK:Update()
    local now = GetTime and GetTime() or 0
    for _, b in ipairs(ns.Data.books or {}) do
        local c = ns.Inventory:Count({ itemID = b.item })
        if (snapshot[b.item] or 0) > 0 and c == 0 and now - pendingTurnIn < 10 then
            ns.char.books[b.item] = true
        end
        snapshot[b.item] = c
    end
end

function BK:SetTurnedIn(item, on)
    ns.char.books[item] = on and true or nil
end

ns:RegisterEvent("QUEST_TURNED_IN", function(_, questID)
    if ns.char then BK:OnTurnedIn(questID) end
end)
