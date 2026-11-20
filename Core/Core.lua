-- Journal Assistant - Core
-- Namespace, saved variables, event dispatch, internal message bus and throttled refresh.

local ADDON, ns = ...
ns.name = ADDON
ns.Data = ns.Data or {}

local function GetMeta(field)
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(ADDON, field)
    elseif GetAddOnMetadata then
        return GetAddOnMetadata(ADDON, field)
    end
end
ns.version = GetMeta("Version") or "dev"
if ns.version:find("@", 1, true) then ns.version = "dev" end -- unpackaged checkout

---------------------------------------------------------------------------
-- Utilities
---------------------------------------------------------------------------
ns.GOLD = "|cffd4af37"
ns.GREY = "|cff8a8a8a"
ns.RED = "|cffd05050"
ns.GREEN = "|cff6fbf6f"
ns.ORANGE = "|cffe08a3a"

function ns.Print(...)
    local msg = ""
    for i = 1, select("#", ...) do
        msg = msg .. (i > 1 and " " or "") .. tostring((select(i, ...)))
    end
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(ns.GOLD .. "JA|r: " .. msg)
    else
        print("JA: " .. msg)
    end
end

function ns.Debug(...)
    if ns.db and ns.db.debug then ns.Print(ns.GREY .. "[debug]|r", ...) end
end

function ns.IsAddOnLoaded(name)
    if C_AddOns and C_AddOns.IsAddOnLoaded then
        local ok, loaded = pcall(C_AddOns.IsAddOnLoaded, name)
        return ok and loaded and true or false
    elseif IsAddOnLoaded then
        local ok, loaded = pcall(IsAddOnLoaded, name)
        return ok and loaded and true or false
    end
    return false
end

-- Safe nested lookup: ns.Has("C_TradeSkillUI", "GetAllRecipeIDs")
function ns.Has(...)
    local t = _G
    for i = 1, select("#", ...) do
        if type(t) ~= "table" then return false end
        t = t[(select(i, ...))]
    end
    return t ~= nil
end

-- Read x, y from a position object. Clients differ: some return a
-- Vector2D mixin (GetXY), others a plain table with x / y fields.
function ns.XY(v)
    if type(v) ~= "table" then return nil end
    if type(v.x) == "number" and type(v.y) == "number" then return v.x, v.y end
    if type(v.GetXY) == "function" then
        local ok, x, y = pcall(v.GetXY, v)
        if ok and type(x) == "number" then return x, y end
    end
    if type(v[1]) == "number" then return v[1], v[2] end
    return nil
end

function ns.Clamp(v, lo, hi)
    if v < lo then return lo elseif v > hi then return hi end
    return v
end

function ns.CopyDefaults(src, dst)
    if type(dst) ~= "table" then dst = {} end
    for k, v in pairs(src) do
        if type(v) == "table" then
            dst[k] = ns.CopyDefaults(v, dst[k])
        elseif dst[k] == nil then
            dst[k] = v
        end
    end
    return dst
end

function ns.Lower(s)
    return s and string.lower(s) or nil
end

function ns.PlayerLevel()
    return ns.levelOverride or (UnitLevel and UnitLevel("player")) or 1
end

function ns.PlayerFaction()
    local f = UnitFactionGroup and UnitFactionGroup("player")
    return f or "Alliance"
end

---------------------------------------------------------------------------
-- Saved variables
---------------------------------------------------------------------------
ns.defaults = {
    account = {
        autoNav = false,                 -- Automatic Waypoint Navigation
        arrowMode = false,               -- quick toggle: TomTom arrow follows the active task
        overrideForeignWaypoint = false, -- allow auto-nav to replace a map pin we did not create
        useApproxCoords = true,          -- use bundled (unverified) Classic coordinates
        navProvider = "auto",            -- auto | tomtom | blizzard
        showMinimap = true,
        minimapAngle = 215,
        showTracker = true,
        lockTracker = false,
        compact = false,
        allowDangerous = false,
        includeBank = true,
        debug = false,
        window = { point = "CENTER", x = 0, y = 40, w = 430, h = 540 },
        tracker = { point = "TOPRIGHT", x = -230, y = -240 },
        learnedLocations = {}, -- [key] = { mapID, x, y, zone, note }
        itemIDs = {},          -- [lower(name)] = itemID, learned from bags/recipe scans
    },
    char = {
        priorities = {},       -- [category key] = "high" | "normal" | "low"
        selectedTask = nil,
        taskState = {},        -- [taskId] = { done, skipped, manual, doneMark, ... }
        collapsed = {},        -- UI section collapse state
        filter = "ALL",
        routeMode = true,
        tracked = {},          -- [guide task id] = true: switched On (added to the Plan)
    },
}

-- Modules add their own saved settings (before ADDON_LOADED): scope "account" | "char"
function ns:RegisterDefaults(scope, tbl)
    for k, v in pairs(tbl) do ns.defaults[scope][k] = v end
end

-- Display names of task categories (professions, guide groups)
ns.categoryNames, ns.categoryIcons = {}, {}
function ns:RegisterCategory(key, name, icon) ns.categoryNames[key], ns.categoryIcons[key] = name, icon end
function ns:CategoryName(key) return key and (ns.categoryNames[key] or key) end

function ns:InitDB()
    JA_DB = ns.CopyDefaults(ns.defaults.account, JA_DB)
    JA_CharDB = ns.CopyDefaults(ns.defaults.char, JA_CharDB)
    ns.db = JA_DB
    ns.char = JA_CharDB
end

---------------------------------------------------------------------------
-- Internal message bus
---------------------------------------------------------------------------
local listeners = {}
function ns:On(msg, fn)
    listeners[msg] = listeners[msg] or {}
    table.insert(listeners[msg], fn)
end

function ns:Fire(msg, ...)
    local list = listeners[msg]
    if not list then return end
    for i = 1, #list do
        local ok, err = pcall(list[i], ...)
        if not ok then
            ns.lastError = err
            ns.Print(ns.RED .. "error in " .. msg .. ":|r " .. tostring(err))
        end
    end
end

---------------------------------------------------------------------------
-- WoW event dispatch (registration is guarded: unknown events on a custom
-- client must not break loading).
---------------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
local handlers = {}
ns.registeredEvents = {}
ns.failedEvents = {}

function ns:RegisterEvent(event, fn)
    if not handlers[event] then
        handlers[event] = {}
        local ok = pcall(eventFrame.RegisterEvent, eventFrame, event)
        if ok then
            ns.registeredEvents[event] = true
        else
            ns.failedEvents[event] = true
        end
    end
    table.insert(handlers[event], fn)
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
    local list = handlers[event]
    if not list then return end
    for i = 1, #list do
        local ok, err = pcall(list[i], event, ...)
        if not ok then
            ns.lastError = err
            ns.Debug("event", event, "failed:", err)
        end
    end
end)

---------------------------------------------------------------------------
-- Throttled refresh pipeline: planner (its sources read live state) -> UI -> navigation
---------------------------------------------------------------------------
local pending = false
local THROTTLE = 0.4

function ns:RequestRefresh(reason)
    ns.lastRefreshReason = reason
    if pending then return end
    pending = true
    C_Timer.After(THROTTLE, function()
        pending = false
        ns:Refresh()
    end)
end

function ns:Refresh()
    if not ns.ready then return end
    local ok, err = pcall(function() ns.Planner:Build() end)
    if not ok then
        ns.lastError = err
        ns.Print(ns.RED .. "refresh failed:|r " .. tostring(err))
    end
    ns:Fire("PLAN_UPDATED")
end

---------------------------------------------------------------------------
-- Priorities (per category: profession or guide group)
---------------------------------------------------------------------------
ns.PRIORITY_WEIGHT = { high = 1.6, normal = 1.0, low = 0.5 }
function ns:GetPriority(key)
    return (ns.char and ns.char.priorities[key]) or "normal"
end

function ns:CyclePriority(key)
    local cur = ns:GetPriority(key)
    local nextP = (cur == "normal" and "high") or (cur == "high" and "low") or "normal"
    ns.char.priorities[key] = nextP
    ns:RequestRefresh("priority")
    return nextP
end
