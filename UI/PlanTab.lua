-- Journal Assistant - Plan tab (generic, first and default tab)
-- The routed task list, then tasks waiting on requirements, skipped and done.

local _, ns = ...
local UI = ns.UI

-- filter cycles through the categories that have tasks right now
local function FilterKeys()
    local keys, seen = { "ALL" }, {}
    for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
        for _, t in ipairs(list) do
            if t.prof and not seen[t.prof] then seen[t.prof] = true; keys[#keys + 1] = t.prof end
        end
    end
    return keys
end

local function Render(L)
    local filterLabel = (ns.char.filter == "ALL" or not ns.char.filter) and "All" or UI.CategoryLabel(ns.char.filter)
    L.header("CURRENT PLAN", "Filter: " .. filterLabel, function()
        local keys = FilterKeys()
        local cur = ns.char.filter or "ALL"
        local idx = 1
        for i, k in ipairs(keys) do if k == cur then idx = i end end
        ns.char.filter = keys[(idx % #keys) + 1]
        UI:Refresh()
    end, ns.char.routeMode and "Route: on" or "Route: off", function()
        ns.char.routeMode = not ns.char.routeMode
        ns:RequestRefresh("route")
    end)
    if ns.char.routeMode and #ns.Planner.route > 0 then
        L.label("Route: " .. table.concat(ns.Planner.route, "  >  "))
    end
    if L.tasks(ns.Planner.ordered, "active") == 0 then L.label("Nothing to do for this filter.") end
    if #ns.Planner.blocked > 0 then
        L.label(ns.GOLD .. "Requirements not met yet|r")
        L.tasks(ns.Planner.blocked, "blocked")
    end
    if #ns.Planner.skippedList > 0 then
        L.label(ns.GOLD .. "Skipped|r")
        L.tasks(ns.Planner.skippedList, "skipped")
    end
    if #ns.Planner.doneList > 0 then
        local dc = ns.char.collapsed.done ~= false
        local h = L.header((dc and "+ " or "- ") .. ("COMPLETED (%d)"):format(#ns.Planner.doneList))
        h:SetScript("OnClick", function() ns.char.collapsed.done = not dc and true or false; UI:Refresh() end)
        if not dc then L.tasks(ns.Planner.doneList, "done") end
    end
end

UI:AddTab({ key = "PLAN", label = "Plan", order = 10, render = Render,
    count = function() return #ns.Planner.ordered end })
ns:AddCommand("plan", function() UI:Show(); UI:SelectTab("PLAN") end)
