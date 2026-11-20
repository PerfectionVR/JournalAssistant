-- Journal Assistant - Guide group tabs (generic)
-- A tab listing one task group of the planner (t.group): available now,
-- later (gated), completed. Rows have an On/Off switch that adds the task
-- to the Plan. Used by the guides: UI:AddGroupTab{ key, label, title, order,
-- setting, summary = fn(group) -> text, count = fn() }.

local _, ns = ...
local UI = ns.UI

local function EmptyGroup() return { active = {}, blocked = {}, done = {}, skipped = {} } end

function UI:AddGroupTab(def)
    local key = def.key
    def.count = def.count or function()
        local g = ns.Planner.groups[key]
        return g and #g.active or 0
    end
    def.render = function(L)
        local g = ns.Planner.groups[key] or EmptyGroup()
        local summary = def.summary and def.summary(g) or ("%d now, %d later"):format(#g.active, #g.blocked)
        local showAll = ns.char.collapsed["all:" .. key]
        L.header(def.title .. "   " .. ns.GREY .. summary .. "|r",
            #g.blocked > 6 and (showAll and "Less" or "All later") or nil,
            function() ns.char.collapsed["all:" .. key] = not showAll; UI:Refresh() end)
        if #g.active == 0 and #g.blocked == 0 then L.label("Nothing to do here right now.") end
        L.tasks(g.active, "active", true)
        if #g.blocked > 0 then
            L.label(ns.GOLD .. "Later|r")
            local list = g.blocked
            if not showAll and #list > 6 then
                list = {}
                for i = 1, 6 do list[i] = g.blocked[i] end
            end
            L.tasks(list, "blocked", true)
            if list ~= g.blocked then L.label(("... %d more (press All later)"):format(#g.blocked - 6)) end
        end
        if #g.done > 0 then
            local ck = "done:" .. key
            local dc = ns.char.collapsed[ck] ~= false
            local h = L.header((dc and "+ " or "- ") .. ("COMPLETED (%d)"):format(#g.done))
            h:SetScript("OnClick", function() ns.char.collapsed[ck] = not dc and true or false; UI:Refresh() end)
            if not dc then
                L.label(ns.GREY .. "Right-click one to put it back if it is not really done.|r")
                L.tasks(g.done, "done", true)
            end
        end
    end
    UI:AddTab(def)
end
