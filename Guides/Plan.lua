-- Journal Assistant - Guides in the planner
--
-- Guide tabs (class quests, library books, camping) are task groups: their
-- tasks are listed on their own tab and only go into the Plan when switched On.
-- This file creates ns.GuidePlan, registers the guide sources, the quest
-- progress metrics and what "done" means for a quest step / chain / book.
-- The sources themselves: ClassQuests.lua, BookTasks.lua, Camping.lua (using
-- ChainTasks.lua for quest chains).

local _, ns = ...
local PL = ns.Planner
local GP = {}
ns.GuidePlan = GP

ns:RegisterDefaults("account", {
    showClassQuests = true,
    showBooks = true,
    showCamping = true,
})
ns:RegisterDefaults("char", {
    questDone = {},        -- ["id:123"] / [lower(title)] = true, recorded on quest turn-in
    books = {},            -- [bookItemID] = true once turned in to the librarian
})

ns.Settings:AddCheck("Show class quests", function() return ns.db.showClassQuests end,
    function(v) ns.db.showClassQuests = v; ns:RequestRefresh("classquests") end,
    "Lists your class quest chains (stances, pets, totems, forms...) as soon as your level allows.")
ns.Settings:AddCheck("Show Library Books guide", function() return ns.db.showBooks end,
    function(v) ns.db.showBooks = v; ns:RequestRefresh("books") end)
ns.Settings:AddCheck("Show Camping & Sleeping Bag guide", function() return ns.db.showCamping end,
    function(v) ns.db.showCamping = v; ns:RequestRefresh("camping") end)

ns:RegisterCategory("CLASS", "Class quests", "Interface\\Icons\\INV_Misc_Book_11")
ns:RegisterCategory("BOOKS", "Library books", "Interface\\Icons\\INV_Misc_Book_09")
ns:RegisterCategory("CAMPING", "Camping", "Interface\\Icons\\Spell_Fire_Fire")

PL:AddSource(70, "class quests", function(ctx) GP:AddClassQuests(ctx) end)
PL:AddSource(80, "books", function(ctx) GP:AddBooks(ctx) end)
PL:AddSource(90, "camping", function(ctx) GP:AddCamping(ctx) end)

PL:AddStage("finish", function(ctx) PL.bookSummary = ctx.bookSummary end)

-- metrics: one quest objective / a whole chain
PL:AddMetric(function(t, m)
    if not (m.questObj and ns.QuestChains) then return nil end
    local list = ns.QuestChains:Objectives(m.questObj.step)
    local e = list and list[m.questObj.index]
    if not e then return nil end
    return { done = e.done, frac = e.need > 0 and math.min(1, e.have / e.need) or 0,
             text = ("%d/%d %s"):format(e.have, e.need, e.o.name or "") }
end)
PL:AddMetric(function(t, m)
    if not (m.questChain and ns.QuestChains) then return nil end
    local chain = ns.QuestChains:ChainByKey(m.questChain)
    if not chain then return nil end
    local st = ns.QuestChains:State(chain)
    return { done = st.complete, frac = st.total > 0 and st.nDone / st.total or 0,
             text = ("Steps %d/%d"):format(st.nDone, st.total) }
end)

-- marking done by hand
local function MarkStep(qs, on)
    local key = qs.id and ("id:" .. qs.id) or (qs.name and string.lower(qs.name))
    if key then ns.char.questDone[key] = on and true or nil end
    if not on and qs.name then ns.char.questDone[string.lower(qs.name)] = nil end
end

PL:AddDoneHandler(function(t, done)
    -- a book ticked off counts as turned in
    if t.bookItem and ns.Books then ns.Books:SetTurnedIn(t.bookItem, done) end
    -- a quest step ticked off in the Plan counts as turned in, so the chain advances
    if t.questStep then MarkStep(t.questStep, done) end
    -- un-completing a whole chain (right-click under Completed) forgets the
    -- recorded turn-ins, so it is listed again (quests the server reports as
    -- completed stay completed)
    if not done and t.metric and t.metric.questChain and ns.QuestChains then
        local chain = ns.QuestChains:ChainByKey(t.metric.questChain)
        for _, qs in ipairs(chain and chain.steps or {}) do MarkStep(qs, false) end
    end
end)

-- dashboard tabs
ns.UI:AddGroupTab({ key = "CLASS", label = "Class", title = "CLASS QUESTS", order = 30, setting = "showClassQuests" })
ns.UI:AddGroupTab({ key = "BOOKS", label = "Books", title = "LIBRARY BOOKS", order = 40, setting = "showBooks",
    summary = function()
        local bs = PL.bookSummary
        return bs and ("%d/%d turned in, %d in bags"):format(bs.turned, bs.total, bs.inBags) or nil
    end,
    count = function()
        local bs = PL.bookSummary
        return bs and ("%d/%d"):format(bs.turned, bs.total) or 0
    end })
ns.UI:AddGroupTab({ key = "CAMPING", label = "Camping", title = "CAMPING & SLEEPING BAG", order = 50, setting = "showCamping" })

-- slash shortcuts to the tabs
ns:AddCommand("class", function() ns.UI:Show(); ns.UI:SelectTab("CLASS") end)
ns:AddCommand("books", function() ns.UI:Show(); ns.UI:SelectTab("BOOKS") end)
ns:AddCommand("camping", function() ns.UI:Show(); ns.UI:SelectTab("CAMPING") end,
    "/ja plan | professions | class | books | camping - open that tab")
