-- Journal Assistant - Slash commands (/ja)
--
-- ns:AddCommand(names, fn(rest), help) registers a sub-command; modules add
-- their own (profession targets, tab shortcuts, ...). The generic ones live here.

local _, ns = ...

local commands, help = {}, { "/ja - toggle dashboard" }

function ns:AddCommand(names, fn, helpLine)
    if type(names) == "string" then names = { names } end
    for _, n in ipairs(names) do commands[n] = fn end
    if helpLine then help[#help + 1] = helpLine end
end

local function ShowHelp()
    for _, l in ipairs(help) do ns.Print(l) end
end

SLASH_JOURNALASSIST1 = "/ja"
SLASH_JOURNALASSIST2 = "/journal"
SLASH_JOURNALASSIST3 = "/fpa" -- old name, kept so muscle memory still works
SlashCmdList["JOURNALASSIST"] = function(msg)
    if not ns.ready then ns.Print("Not ready yet.") return end
    local cmd, rest = (msg or ""):match("^%s*(%S*)%s*(.-)%s*$")
    cmd = (cmd or ""):lower()
    if cmd == "" then cmd = "toggle" end
    local fn = commands[cmd]
    if fn then fn(rest or "") else ShowHelp() end
end

---------------------------------------------------------------------------
-- Generic commands
---------------------------------------------------------------------------
ns:AddCommand({ "toggle", "show" }, function() ns.UI:Toggle() end)
ns:AddCommand("next", function() ns.Planner:SelectNext() end, "/ja next - select next recommended task")
ns:AddCommand("route", function()
    local r = ns.Planner.route
    ns.Print("Route: " .. (#r > 0 and table.concat(r, " > ") or "no zone travel needed"))
    for i, t in ipairs(ns.Planner.ordered) do
        if i > 10 then ns.Print("  ...") break end
        ns.Print(("  %d. %s%s"):format(i, t.title, t.zone and (ns.GREY .. " (" .. t.zone .. ")|r") or ""))
    end
    ns.UI:Show()
end, "/ja route - show the current route")
ns:AddCommand({ "arrow", "tomtom" }, function() ns.Navigation:ToggleArrow() end,
    "/ja arrow - quick toggle: TomTom arrow (or map pin) follows the active task")
ns:AddCommand("nav", function() ns.Navigation:SetAuto(not ns.db.autoNav) end, "/ja nav - toggle Automatic Waypoint Navigation")
ns:AddCommand({ "go", "navigate" }, function() ns.Navigation:Navigate(ns.Planner.active, true) end,
    "/ja go - navigate to the active task now")
ns:AddCommand("refresh", function()
    ns.Inventory:MarkDirty()
    ns:Refresh()
    ns.Print("Refreshed.")
end, "/ja refresh - refresh all data")
ns:AddCommand("mark", function(rest) ns.Routes:MarkCurrent(rest == "zone" and nil or ns.Planner.active) end,
    "/ja mark - save your position as the active task's destination")
ns:AddCommand("unmark", function()
    local t = ns.Planner.active
    if t then ns.db.learnedLocations[t.id] = nil; ns.Print("Removed saved location for: " .. t.title) end
end)
ns:AddCommand("compact", function() ns.UI:Show(); ns.UI:SetCompact(not ns.db.compact) end)
ns:AddCommand("tracker", function() ns.Tracker:SetShown(not ns.db.showTracker) end)
ns:AddCommand("minimap", function() ns.Minimap:SetShown(not ns.db.showMinimap) end,
    "/ja compact | tracker | minimap | config")
ns:AddCommand({ "config", "options", "settings" }, function() ns.Settings:Toggle() end)
ns:AddCommand("reset", function() ns.UI:ResetPosition() end)
ns:AddCommand({ "debug", "diag" }, function() ns.Diagnostics:Show() end, "/ja debug - compatibility & API diagnostics")
ns:AddCommand("verbose", function()
    ns.db.debug = not ns.db.debug
    ns.Print("Debug messages: " .. tostring(ns.db.debug))
end)
