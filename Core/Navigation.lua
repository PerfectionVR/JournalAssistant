-- Journal Assistant - Navigation
--
-- Providers (in priority order, each detected before use):
--   1. TomTom  - public API only: TomTom:AddWaypoint(mapID, x, y, opts) and
--                TomTom:RemoveWaypoint(uid). We only ever remove the uid WE got.
--   2. Blizzard map pin - C_Map.SetUserWaypoint + C_SuperTrack. Follow The Arrow
--                and similar arrow addons that follow the super-tracked pin will
--                pick this up; we never touch Follow The Arrow's private state.
--                The pin is a single shared slot, so we never replace a pin we
--                did not create unless you press Navigate or enable the override.
--   3. Built-in text guidance (zone, coordinates, distance, compass direction)
--                shown in the tracker - always available.

local _, ns = ...
local N = {}
ns.Navigation = N

N.owned = { tomtomUID = nil, pin = nil, key = nil, provider = nil, taskId = nil }
N.lastMessage = nil
N.current = nil -- resolved destination for built-in guidance

local FTA_NAMES = { "FollowTheArrow", "Follow The Arrow", "FollowTheArrow_Forever", "FTA" }

function N:DetectFTA()
    for _, n in ipairs(FTA_NAMES) do
        if ns.IsAddOnLoaded(n) then return n end
    end
    return nil
end

function N:HasTomTom()
    return ns.IsAddOnLoaded("TomTom") and type(TomTom) == "table"
        and type(TomTom.AddWaypoint) == "function" and type(TomTom.RemoveWaypoint) == "function"
end

function N:HasBlizzardPin()
    return ns.Has("C_Map", "SetUserWaypoint") and ns.Has("C_Map", "ClearUserWaypoint")
        and type(UiMapPoint) == "table" and type(UiMapPoint.CreateFromCoordinates) == "function"
end

function N:ProviderStatus()
    return {
        tomtom = self:HasTomTom(),
        blizzard = self:HasBlizzardPin(),
        fta = self:DetectFTA(),
        superTrack = ns.Has("C_SuperTrack", "SetSuperTrackedUserWaypoint"),
    }
end

local function msg(text)
    N.lastMessage = text
    ns.Print(text)
end

local function sameSpot(a, b)
    return a and b and a.mapID == b.mapID and math.abs(a.x - b.x) < 0.002 and math.abs(a.y - b.y) < 0.002
end

---------------------------------------------------------------------------
-- Owned waypoint management
---------------------------------------------------------------------------
function N:ClearTomTom()
    local uid = self.owned.tomtomUID
    if uid and self:HasTomTom() then
        pcall(TomTom.RemoveWaypoint, TomTom, uid)
    end
    self.owned.tomtomUID = nil
end

function N:CurrentPin()
    if not (ns.Has("C_Map", "HasUserWaypoint") and C_Map.HasUserWaypoint()) then return nil end
    local ok, p = pcall(C_Map.GetUserWaypoint)
    if ok and type(p) == "table" and p.uiMapID then
        local x, y = ns.XY(p.position)
        if x then return { mapID = p.uiMapID, x = x, y = y } end
        -- a pin exists but its position is unreadable: treat it as foreign
        return { mapID = p.uiMapID, x = -1, y = -1 }
    end
    return nil
end

function N:IsOwnPin()
    local cur = self:CurrentPin()
    return cur and self.owned.pin and sameSpot(cur, self.owned.pin)
end

function N:ClearPin()
    if self:IsOwnPin() then
        pcall(C_Map.ClearUserWaypoint)
    end
    self.owned.pin = nil
end

function N:ClearOwned()
    self:ClearTomTom()
    self:ClearPin()
    self.owned.key, self.owned.provider, self.owned.taskId = nil, nil, nil
end

---------------------------------------------------------------------------
-- Providers
---------------------------------------------------------------------------
local function SetTomTom(dest, manual)
    local opts = {
        title = "JA: " .. (dest.title or "Profession task")
            .. (dest.zoneOnly and " (zone)" or (dest.approx and " (~approx)" or "")),
        persistent = false, minimap = true, world = true, from = "JournalAssistant",
        -- the TomTom arrow is only claimed on an explicit Navigate press or when
        -- the user enabled overriding other waypoints
        crazy = (manual or ns.db.overrideForeignWaypoint or ns.db.arrowMode) and true or false,
        silent = true,
    }
    local ok, uid = pcall(TomTom.AddWaypoint, TomTom, dest.mapID, dest.x, dest.y, opts)
    if ok and uid then
        N.owned.tomtomUID = uid
        if opts.crazy and type(TomTom.SetCrazyArrow) == "function" then
            pcall(TomTom.SetCrazyArrow, TomTom, uid, 15, opts.title)
        end
        return true
    end
    return false, ok and "TomTom returned no waypoint" or tostring(uid)
end

local function SetPin(dest, manual)
    local cur = N:CurrentPin()
    local claim = manual or ns.db.overrideForeignWaypoint or ns.db.arrowMode
    if cur and not N:IsOwnPin() and not claim then
        return false, "A map pin set by you or another addon is active; it was left alone (press Navigate, or enable 'Override other waypoints')."
    end
    if ns.Has("C_Map", "CanSetUserWaypointOnMap") and not C_Map.CanSetUserWaypointOnMap(dest.mapID) then
        return false, "This map does not accept user waypoints."
    end
    local ok, err = pcall(function()
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(dest.mapID, dest.x, dest.y))
    end)
    if not ok then return false, tostring(err) end
    N.owned.pin = { mapID = dest.mapID, x = dest.x, y = dest.y }
    if ns.Has("C_SuperTrack", "SetSuperTrackedUserWaypoint") then
        local busy = ns.Has("C_SuperTrack", "IsSuperTrackingAnything") and C_SuperTrack.IsSuperTrackingAnything()
            and not (ns.Has("C_SuperTrack", "IsSuperTrackingUserWaypoint") and C_SuperTrack.IsSuperTrackingUserWaypoint())
        if claim or not busy then
            pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, true)
        end
    end
    if cur and manual and not sameSpot(cur, N.owned.pin) and not (N.lastOwnPinBefore and sameSpot(cur, N.lastOwnPinBefore)) then
        ns.Print("Replaced the previous map pin (you pressed Navigate).")
    end
    return true
end

---------------------------------------------------------------------------
-- Public
---------------------------------------------------------------------------
-- manual = true when the user pressed Navigate / typed a command.
function N:Navigate(task, manual)
    task = task or ns.Planner.active
    if not task then
        if manual then msg("No active task to navigate to.") end
        return false
    end
    local dest, why = ns.Routes:ResolveDestination(task)
    N.current = dest and dest or nil
    N.currentTask = task
    ns:Fire("NAV_UPDATED")
    if not dest then
        if manual then msg(why) end
        -- nothing to point at any more (other task, or arrived in the zone):
        -- remove only the waypoint we created
        if N.owned.key then N:ClearOwned() end
        return false
    end
    local key = ("%d:%.4f:%.4f"):format(dest.mapID, dest.x, dest.y)
    if N.owned.key == key and not manual then return true end -- no duplicates

    local pref = ns.db.navProvider
    local useTomTom = (pref == "auto" or pref == "tomtom") and self:HasTomTom()
    local ok, err

    N.lastOwnPinBefore = N.owned.pin
    self:ClearOwned() -- remove only waypoints we created earlier
    if useTomTom then
        ok, err = SetTomTom(dest, manual)
        if ok then N.owned.provider = "TomTom" end
    end
    if not ok and pref ~= "tomtom" and self:HasBlizzardPin() then
        ok, err = SetPin(dest, manual)
        if ok then N.owned.provider = "Map pin" end
    end
    if ok then
        N.owned.key, N.owned.taskId = key, task.id
        if manual then
            if dest.zoneOnly then
                ns.Print(("Navigating (%s) towards %s (zone; no exact spot known)"):format(N.owned.provider, dest.zone or "?"))
            else
                ns.Print(("Navigating (%s) to %s %.1f, %.1f%s"):format(N.owned.provider, dest.zone or "?",
                    dest.x * 100, dest.y * 100, dest.approx and " (~approx Classic coords)" or ""))
            end
        end
        return true
    end
    if manual or not N.warnedOnce then
        N.warnedOnce = true
        msg("Automatic waypoint unavailable: " .. tostring(err or "no navigation provider") .. " Text guidance is shown in the tracker.")
    end
    return false
end

function N:OnActiveChanged(task)
    if ns.db.autoNav then
        self:Navigate(task, false)
    else
        local dest = task and ns.Routes:ResolveDestination(task)
        N.current, N.currentTask = dest, task
        ns:Fire("NAV_UPDATED")
    end
end

-- Quick toggle: the arrow (TomTom if installed, else the map pin) always
-- points at the active task. Turning it on enables automatic navigation and
-- lets JA claim the arrow; turning it off removes only JA's waypoints.
function N:SetArrowMode(on)
    ns.db.arrowMode = on and true or false
    if on then
        ns.db.autoNav = true
        N.owned.key = nil
        N.warnedOnce = nil
        local provider = self:HasTomTom() and "TomTom" or (self:HasBlizzardPin() and "map pin" or nil)
        if provider then
            ns.Print("Arrow: " .. ns.GREEN .. "ON|r - " .. provider .. " now follows the active task."
                .. (provider ~= "TomTom" and (ns.GREY .. " (TomTom is not installed)|r") or ""))
        else
            ns.Print("Arrow: ON, but no TomTom or map pin API was found. Only text guidance is shown.")
        end
        self:Navigate(ns.Planner.active, false)
    else
        ns.db.autoNav = false
        self:ClearOwned()
        ns.Print("Arrow: " .. ns.RED .. "OFF|r (removed only JA's waypoint)")
    end
    ns:Fire("SETTINGS_CHANGED")
end

function N:ToggleArrow()
    self:SetArrowMode(not ns.db.arrowMode)
end

function N:SetAuto(on)
    ns.db.autoNav = on and true or false
    if not on then ns.db.arrowMode = false end
    if on then
        local st = self:ProviderStatus()
        if not st.tomtom and not st.blizzard then
            msg("Automatic Waypoint Navigation is ON, but no waypoint provider was found. Only text guidance will be shown.")
        else
            ns.Print("Automatic Waypoint Navigation: " .. ns.GREEN .. "ON|r (" .. (st.tomtom and "TomTom" or "map pin") .. ")")
        end
        N.owned.key = nil
        self:Navigate(ns.Planner.active, false)
    else
        self:ClearOwned()
        ns.Print("Automatic Waypoint Navigation: " .. ns.RED .. "OFF|r (removed only waypoints created by JA)")
    end
    ns:Fire("SETTINGS_CHANGED")
end

---------------------------------------------------------------------------
-- Built-in guidance text
---------------------------------------------------------------------------
local DIRS = { "N", "NE", "E", "SE", "S", "SW", "W", "NW" }

function N:GuidanceText()
    local task = N.currentTask or ns.Planner.active
    if not task then return "" end
    local dest = N.current
    if not dest then
        if task.zone then
            local cur = ns.Routes:CurrentZone()
            if cur == task.zone then return "You are in " .. task.zone end
            return "Travel to " .. task.zone
        end
        return "Anywhere"
    end
    if dest.zoneOnly then return "Travel to " .. (dest.zone or "?") end
    local text = ("%s %.1f, %.1f%s"):format(dest.zone or "", dest.x * 100, dest.y * 100, dest.approx and " ~" or "")
    local mapID, px, py = ns.Routes:PlayerPosition()
    if mapID == dest.mapID and px and ns.Has("C_Map", "GetMapWorldSize") then
        local ok, w, h = pcall(C_Map.GetMapWorldSize, mapID)
        if ok and w and h and w > 0 then
            local dx, dy = (dest.x - px) * w, (dest.y - py) * h
            local dist = math.sqrt(dx * dx + dy * dy)
            local atan2 = math.atan2 or math.atan
            local ang = math.deg(atan2(dx, -dy)) % 360
            local dir = DIRS[(math.floor((ang + 22.5) / 45) % 8) + 1]
            text = text .. ("  ·  %d yd %s"):format(math.floor(dist), dir)
            if dist < 25 then text = text .. "  ·  arrived" end
        end
    elseif dest.zone then
        local cur = ns.Routes:CurrentZone()
        if cur ~= dest.zone then text = "Travel to " .. text end
    end
    return text
end
