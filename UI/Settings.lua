-- Journal Assistant - Settings panel
-- The same panel content is built twice: once inside a floating window (opened
-- by the Options button / right-clicking the minimap icon - works in combat-free
-- and restricted situations alike) and once registered in the game's
-- AddOns settings list when the Settings API is available.

local _, ns = ...
local T = ns.Theme
local C = T.colors
local S = {}
ns.Settings = S

local floatFrame
S.panels = {}

-- Modules add their own options (shown in this order below the generic ones)
S.extra = {}
function S:AddCheck(label, get, set, tip) S.extra[#S.extra + 1] = { label = label, get = get, set = set, tip = tip } end
function S:AddCycle(label, values, get, set) S.extra[#S.extra + 1] = { label = label, values = values, get = get, set = set } end

local function Build(parent, isCanvas)
    local y = -10
    local function title(text)
        local fs = T.Text(parent, isCanvas and 15 or 13, C.gold)
        fs:SetPoint("TOPLEFT", 14, y)
        fs:SetText(text)
        y = y - 24
    end
    local function note(text)
        local fs = T.Text(parent, 10, C.dim)
        fs:SetPoint("TOPLEFT", 40, y + 4)
        fs:SetPoint("RIGHT", parent, "RIGHT", -14, 0)
        if fs.SetWordWrap then fs:SetWordWrap(true) end
        fs:SetText(text)
        y = y - 16
    end
    local checks = {}
    local function check(label, get, set, tip)
        local cb = T.Check(parent, label, get, set, tip)
        cb:SetPoint("TOPLEFT", 14, y)
        checks[#checks + 1] = cb
        y = y - 24
        return cb
    end
    local function cycle(label, values, get, set)
        local fs = T.Text(parent, 11, C.text)
        fs:SetPoint("TOPLEFT", 18, y - 2)
        fs:SetText(label)
        local b = T.Button(parent, "", 110, 18)
        b:SetPoint("TOPLEFT", 220, y)
        local function upd() local v = get(); b:SetLabel(values[v] or tostring(v)) end
        b:SetScript("OnClick", function()
            local keys, cur = {}, get()
            for k in pairs(values) do keys[#keys + 1] = k end
            table.sort(keys, function(a, c) return tostring(a) < tostring(c) end)
            local idx = 1
            for i, k in ipairs(keys) do if k == cur then idx = i end end
            set(keys[(idx % #keys) + 1])
            upd()
        end)
        b:SetScript("OnShow", upd)
        upd()
        checks[#checks + 1] = { Refresh = upd }
        y = y - 26
    end

    title("Journal Assistant  " .. ns.GREY .. ns.version .. "|r")

    check("Arrow follows active task (quick toggle)", function() return ns.db.arrowMode end,
        function(v) ns.Navigation:SetArrowMode(v) end,
        "Points the TomTom arrow (or the map pin) at the active task and keeps it updated. Same as the Arrow button, /ja arrow or its key binding.")
    check("Automatic Waypoint Navigation", function() return ns.db.autoNav end,
        function(v) ns.Navigation:SetAuto(v) end,
        "Update the waypoint automatically when the active task changes. Uses TomTom if installed, otherwise the game's map pin.")
    note("Only waypoints created by JA are ever removed or replaced.")
    check("Allow auto-navigation to replace other waypoints", function() return ns.db.overrideForeignWaypoint end,
        function(v) ns.db.overrideForeignWaypoint = v end,
        "Off: JA never replaces a map pin set by you/Questie/others and does not claim the TomTom arrow automatically.")
    cycle("Navigation provider", { auto = "Auto", tomtom = "TomTom only", blizzard = "Map pin only" },
        function() return ns.db.navProvider end,
        function(v) ns.db.navProvider = v; ns.Navigation:ClearOwned() end)
    check("Use approximate Classic coordinates (unverified)", function() return ns.db.useApproxCoords end,
        function(v) ns.db.useApproxCoords = v; ns:RequestRefresh("coords") end,
        "Bundled NPC coordinates come from Classic and may be wrong on Forever. Locations you save with /ja mark are always used first.")
    y = y - 6

    check("Show minimap button", function() return ns.db.showMinimap end, function(v) ns.Minimap:SetShown(v) end)
    check("Show on-screen tracker", function() return ns.db.showTracker end, function(v) ns.Tracker:SetShown(v) end)
    check("Lock tracker position", function() return ns.db.lockTracker end, function(v) ns.db.lockTracker = v end)
    check("Compact dashboard (active task only)", function() return ns.db.compact end, function(v) ns.UI:SetCompact(v) end)
    y = y - 6

    check("Allow dangerous zones in the route", function() return ns.db.allowDangerous end,
        function(v) ns.db.allowDangerous = v; ns:RequestRefresh("danger") end,
        "Off: zones more than 8 levels above you are never planned; 4-8 levels above are marked with caution.")
    check("Count bank items as owned materials", function() return ns.db.includeBank end,
        function(v) ns.db.includeBank = v; ns:RequestRefresh("bank") end)
    -- options added by modules (S:AddCheck / S:AddCycle)
    for _, o in ipairs(S.extra) do
        if o.values then cycle(o.label, o.values, o.get, o.set) else check(o.label, o.get, o.set, o.tip) end
    end
    y = y - 6

    local reset = T.Button(parent, "Reset window positions", 160, 20, function()
        ns.UI:ResetPosition()
        ns.db.tracker = { point = "TOPRIGHT", x = -230, y = -240 }
        local tf = _G.JA_Tracker
        if tf then tf:ClearAllPoints(); tf:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -230, -240) end
    end)
    reset:SetPoint("TOPLEFT", 18, y)
    local resetTasks = T.Button(parent, "Reset skipped/completed tasks", 190, 20, function() ns.Planner:ResetStates() end)
    resetTasks:SetPoint("LEFT", reset, "RIGHT", 8, 0)
    y = y - 30
    note("Commands: /ja  ·  /ja next  ·  /ja route  ·  /ja nav  ·  /ja refresh  ·  /ja mark  ·  /ja debug")

    parent:HookScript("OnShow", function()
        for _, c in ipairs(checks) do c:Refresh() end
    end)
    return -y
end

function S:Init()
    -- floating window
    floatFrame = T.Panel(UIParent, "JA_SettingsFloat")
    floatFrame:SetSize(400, 470)
    floatFrame:SetPoint("CENTER", 0, 60)
    floatFrame:SetFrameStrata("DIALOG")
    floatFrame:SetMovable(true)
    floatFrame:EnableMouse(true)
    floatFrame:RegisterForDrag("LeftButton")
    floatFrame:SetScript("OnDragStart", floatFrame.StartMoving)
    floatFrame:SetScript("OnDragStop", floatFrame.StopMovingOrSizing)
    floatFrame:SetClampedToScreen(true)
    floatFrame:Hide()
    table.insert(UISpecialFrames, "JA_SettingsFloat")
    local h = Build(floatFrame, false)
    floatFrame:SetHeight(h + 20)
    local close = T.Button(floatFrame, "x", 18, 16, function() floatFrame:Hide() end)
    close:SetPoint("TOPRIGHT", -6, -6)

    -- Blizzard settings registration (guarded)
    local canvas = CreateFrame("Frame")
    canvas.name = "Journal Assistant"
    Build(canvas, true)
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local ok, cat = pcall(Settings.RegisterCanvasLayoutCategory, canvas, "Journal Assistant")
        if ok and cat then
            pcall(Settings.RegisterAddOnCategory, cat)
            S.category = cat
        end
    elseif InterfaceOptions_AddCategory then
        pcall(InterfaceOptions_AddCategory, canvas)
    end
end

function S:Toggle()
    if not floatFrame then return end
    if floatFrame:IsShown() then floatFrame:Hide() else floatFrame:Show() end
end
