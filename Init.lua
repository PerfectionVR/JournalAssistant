-- Journal Assistant - Bootstrap: saved variables, login, generic events, public API
-- (slash commands: Core/Commands.lua and each module)

local ADDON, ns = ...

---------------------------------------------------------------------------
-- Internal wiring
---------------------------------------------------------------------------
ns:On("PLAN_UPDATED", function()
    -- destination may change without the task changing (zone change, arrival,
    -- saved location); Navigate() de-duplicates, so this never stacks waypoints
    if ns.db.autoNav and ns.ready then ns.Navigation:Navigate(ns.Planner.active, false) end
    ns.UI:Refresh()
    ns.Tracker:Refresh()
end)

-- Key bindings (Bindings.xml): Esc > Options > Keybindings > AddOns
BINDING_HEADER_JA = "Journal Assistant"
BINDING_NAME_JA_TOGGLE_ARROW = "Toggle arrow to active task"
BINDING_NAME_JA_NAVIGATE = "Navigate to active task"
BINDING_NAME_JA_NEXT = "Next task"
BINDING_NAME_JA_TOGGLE_DASHBOARD = "Toggle dashboard"

ns:On("NAV_UPDATED", function()
    ns.UI:RefreshNext()
    ns.Tracker:Refresh()
end)

ns:On("ACTIVE_CHANGED", function(task)
    ns.Navigation:OnActiveChanged(task)
end)

ns:On("TASK_COMPLETED", function(task, text)
    if not ns.ready then return end
    ns.Print(ns.GREEN .. "Completed:|r " .. (text or task.title))
end)

ns:On("SETTINGS_CHANGED", function()
    ns.UI:Refresh()
    ns.Tracker:Refresh()
end)

---------------------------------------------------------------------------
-- Game events (all registrations are guarded in Core)
---------------------------------------------------------------------------
ns:RegisterEvent("ADDON_LOADED", function(_, name)
    if name ~= ADDON then return end
    ns:InitDB()
end)

ns:RegisterEvent("PLAYER_LOGIN", function()
    if not ns.db then ns:InitDB() end
    -- each step isolated: one failing UI piece must not disable the rest
    local steps = {
        { "settings", function() ns.Settings:Init() end },
        { "minimap", function() ns.Minimap:Init() end },
        { "dashboard", function() ns.UI:Create() end },
        { "prices", function() ns.Prices:Init() end },
    }
    for _, s in ipairs(steps) do
        local ok, err = pcall(s[2])
        if not ok then
            ns.lastError = s[1] .. ": " .. tostring(err)
            ns.Print(ns.RED .. "could not create " .. s[1] .. ":|r " .. tostring(err))
        end
    end
    ns.ready = true
    ns:Refresh()
    -- professions can arrive late on login; refresh again shortly after
    C_Timer.After(3, function() ns:RequestRefresh("login-late") end)
    ns.Print(("v%s loaded - /ja to open, /ja debug for diagnostics."):format(ns.version))
end)

-- generic refresh triggers (modules register their own events)
local refreshEvents = {
    "ZONE_CHANGED_NEW_AREA", "PLAYER_ENTERING_WORLD", "QUEST_ACCEPTED", "QUEST_REMOVED", "SPELLS_CHANGED",
}
for _, e in ipairs(refreshEvents) do
    ns:RegisterEvent(e, function(ev) ns:RequestRefresh(ev) end)
end

ns:RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
    ns.levelOverride = tonumber(level)
    C_Timer.After(2, function() ns.levelOverride = nil end)
    ns:RequestRefresh("level")
end)

ns:RegisterEvent("BAG_UPDATE_DELAYED", function()
    ns.Inventory:MarkDirty()
    ns:RequestRefresh("bags")
end)

---------------------------------------------------------------------------
-- Minimal public, read-only API for other addons / macros.
_G.JournalAssistantAPI = {
    ToggleArrow = function() if ns.ready then ns.Navigation:ToggleArrow() end end,
    Navigate = function() if ns.ready then ns.Navigation:Navigate(ns.Planner.active, true) end end,
    NextTask = function() if ns.ready then ns.Planner:SelectNext() end end,
    ToggleDashboard = function() if ns.ready then ns.UI:Toggle() end end,
    GetActiveTask = function()
        local t = ns.Planner.active
        return t and { id = t.id, title = t.title, zone = t.zone, profession = t.prof } or nil
    end,
}
-- module additions (e.g. GetProfessions from Professions/Professions.lua)
for k, v in pairs(ns.publicAPI or {}) do _G.JournalAssistantAPI[k] = v end
