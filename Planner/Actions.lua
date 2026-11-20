-- Journal Assistant - Planner user actions (generic)
-- Select / next / skip / done / switch on for the plan's tasks.

local _, ns = ...
local PL = ns.Planner

function PL:Select(id)
    ns.char.selectedTask = id
    ns:RequestRefresh("select")
end

function PL:SelectNext()
    local list = PL.ordered
    if #list == 0 then ns.Print("Nothing to do: all objectives complete, blocked or skipped.") return end
    local idx = 1
    if PL.active then
        for i, t in ipairs(list) do if t.id == PL.active.id then idx = i + 1 end end
        if idx > #list then idx = 1 end
    end
    PL:Select(list[idx].id)
    ns.Print("Active: " .. list[idx].title)
end

function PL:Skip(id, unskip)
    local s = self:State(id)
    s.skipped = not unskip or nil
    if ns.char.selectedTask == id and not unskip then ns.char.selectedTask = nil end
    ns:RequestRefresh("skip")
end

-- Manual completion; modules react through PL:AddDoneHandler (books turned in,
-- quest steps recorded as turned in, ...)
function PL:SetDone(id, done)
    local s = self:State(id)
    local t = PL.byId[id]
    if t then
        for _, fn in ipairs(PL.doneHandlers) do fn(t, done) end
    end
    if done then
        s.done, s.manual, s.doneMark = true, true, t and PL:MarkFor(t) or nil
        if ns.char.selectedTask == id then ns.char.selectedTask = nil end
    else
        s.done, s.manual = nil, nil
    end
    ns:RequestRefresh("done")
end

-- On/Off switch of a guide-tab task (class quest / camping chain, book, ...)
function PL:SetTracked(id, on)
    ns.char.tracked[id] = on and true or nil
    local t = PL.byId[id]
    if t then ns.Print(t.title .. ": " .. (on and (ns.GREEN .. "on|r - added to the plan") or (ns.GREY .. "off|r"))) end
    -- make its first routed task active so the arrow points there
    if on then PL.selectAfterTrack = id end
    ns:RequestRefresh("track")
end

function PL:ResetStates()
    wipe(ns.char.taskState)
    ns.char.selectedTask = nil
    ns:RequestRefresh("reset")
end
