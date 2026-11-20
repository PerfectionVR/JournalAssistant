-- Journal Assistant - Zones, destinations and route ordering
--
-- * Map IDs are resolved at runtime by zone NAME via C_Map (never hard-coded),
--   because Forever's uiMapIDs are not documented.
-- * Destinations prefer locations you saved yourself with /ja mark (verified),
--   then bundled approximate Classic coordinates (if enabled), else zone only.
-- * Route ordering is a greedy "best value / travel cost" tour over a small
--   zone-link graph, starting from your current zone.

local _, ns = ...
local RT = {}
ns.Routes = RT

---------------------------------------------------------------------------
-- Map index (name -> uiMapID)
---------------------------------------------------------------------------
RT.mapIndex = nil
RT.mapIndexCount = 0

function RT:BuildMapIndex()
    if RT.mapIndex then return RT.mapIndex end
    local index, count = {}, 0
    if not ns.Has("C_Map", "GetMapInfo") then
        RT.mapIndex = index
        return index
    end
    local ZONE = (Enum and Enum.UIMapType and Enum.UIMapType.Zone) or 3
    local CONT = (Enum and Enum.UIMapType and Enum.UIMapType.Continent) or 2
    for id = 1, 3000 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info and info.name and info.mapType == ZONE then
            local lname = string.lower(info.name)
            local parentIsContinent = false
            if info.parentMapID and info.parentMapID > 0 then
                local okP, p = pcall(C_Map.GetMapInfo, info.parentMapID)
                parentIsContinent = okP and p and p.mapType == CONT
            end
            local ex = index[lname]
            -- prefer zones that sit directly on a continent (the "real" outdoor map)
            if not ex or (parentIsContinent and not ex.cont) then
                if not ex then count = count + 1 end
                index[lname] = { id = id, cont = parentIsContinent }
            end
        end
    end
    RT.mapIndex, RT.mapIndexCount = index, count
    return index
end

function RT:MapIDForZone(zone)
    if not zone then return nil end
    local idx = self:BuildMapIndex()
    local e = idx[string.lower(zone)]
    return e and e.id
end

-- Zone name for a Wowhead area ID, asked from the game client (no hard-coded table)
local areaCache = {}
function RT:AreaName(areaID)
    if not areaID then return nil end
    if areaCache[areaID] ~= nil then return areaCache[areaID] or nil end
    local name
    if ns.Has("C_Map", "GetAreaInfo") then
        local ok, n = pcall(C_Map.GetAreaInfo, areaID)
        if ok and type(n) == "string" and n ~= "" then name = n end
    end
    areaCache[areaID] = name or false
    return name
end

-- Zone of a Wowhead NPC entry { id, name, zone, fac, x, y, uiMapID, areaID }
function RT:NpcZone(n)
    return n[3] or self:AreaName(n[8])
end

function RT:CurrentZone()
    local mapID = ns.Has("C_Map", "GetBestMapForUnit") and C_Map.GetBestMapForUnit("player")
    local name
    if mapID then
        local info = C_Map.GetMapInfo(mapID)
        name = info and info.name
    end
    name = name or (GetRealZoneText and GetRealZoneText()) or (GetZoneText and GetZoneText())
    return name, mapID
end

function RT:PlayerPosition()
    if not ns.Has("C_Map", "GetBestMapForUnit") then return nil end
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return nil end
    local ok, pos = pcall(C_Map.GetPlayerMapPosition, mapID, "player")
    if not ok or not pos then return mapID end
    local x, y = ns.XY(pos)
    return mapID, x, y
end

---------------------------------------------------------------------------
-- Safety (level-based)
---------------------------------------------------------------------------
-- returns "safe" | "caution" | "danger" | "unknown", zoneInfo, effectiveMinLevel
-- A zone (or a specific dangerous area inside it, e.g. Stromgarde) is:
--   danger  : its lowest mob level is above yours -> gated ("reach level X")
--   caution : its lowest mob level is within 2 below yours
--   safe    : otherwise
function RT:Safety(zone, level, areaMin)
    local z = zone and ns.Data.zones[zone]
    if not z and not areaMin then return "unknown", nil end
    level = level or ns.PlayerLevel()
    if z and z.city and not areaMin then
        if z.faction and z.faction ~= ns.PlayerFaction() then return "danger", z, 0 end
        return "safe", z, 0
    end
    local min = math.max(z and not z.city and z.min or 0, areaMin or 0)
    if min > level then return "danger", z, min end
    if min >= level - 2 then return "caution", z, min end
    return "safe", z, min
end

function RT:IsAllowed(zone, level, areaMin)
    local s = self:Safety(zone, level, areaMin)
    if s == "danger" and not ns.db.allowDangerous then return false end
    return true
end

---------------------------------------------------------------------------
-- Travel cost graph (Dijkstra over a tiny graph; cached)
---------------------------------------------------------------------------
local graph
local distCache = {}

local function BuildGraph()
    graph = {}
    for _, l in ipairs(ns.Data.zoneLinks) do
        local a, b, w = l[1], l[2], l[3] or 1
        graph[a] = graph[a] or {}
        graph[b] = graph[b] or {}
        graph[a][b] = w
        graph[b][a] = w
    end
end

function RT:Distance(a, b)
    if not a or not b then return 4 end
    if a == b then return 0 end
    if not graph then BuildGraph() end
    local key = a .. "|" .. b
    if distCache[key] then return distCache[key] end
    if not graph[a] or not graph[b] then
        -- unknown zone: same continent guess or far
        local za, zb = ns.Data.zones[a], ns.Data.zones[b]
        local d = (za and zb and za.cont == zb.cont) and 4 or 8
        distCache[key] = d
        return d
    end
    local dist, done = { [a] = 0 }, {}
    while true do
        local best, bestD
        for node, d in pairs(dist) do
            if not done[node] and (not bestD or d < bestD) then best, bestD = node, d end
        end
        if not best then break end
        if best == b then break end
        done[best] = true
        for nb, w in pairs(graph[best]) do
            local nd = bestD + w
            if not dist[nb] or nd < dist[nb] then dist[nb] = nd end
        end
    end
    local d = dist[b] or 10
    distCache[key] = d
    return d
end

---------------------------------------------------------------------------
-- Destinations
---------------------------------------------------------------------------
-- Resolve a task destination to { mapID, x(0-1), y(0-1), title, approx, verified }
function RT:ResolveDestination(task)
    if not task then return nil, "No task selected." end
    local learned = ns.db.learnedLocations
    local L = learned[task.id] or (task.zone and learned["zone:" .. task.zone])
    if L and L.mapID and L.x and L.y then
        return { mapID = L.mapID, x = L.x, y = L.y, title = task.title, verified = true, zone = L.zone }
    end
    local d = task.dest
    if d and d.x and d.y then
        if d.approx and not ns.db.useApproxCoords then
            return nil, "Only approximate Classic coordinates are known for this task (option disabled). Use /ja mark on site to save a verified spot."
        end
        -- verified data (Wowhead / trainer scans) may carry the game's own map ID
        local mapID = d.mapID or self:MapIDForZone(d.zone or task.zone)
        if d.mapID then
            return { mapID = mapID, x = d.x / 100, y = d.y / 100, title = task.title, approx = d.approx, zone = d.zone or task.zone }
        end
        if not mapID then
            return nil, "Could not resolve map for zone '" .. tostring(d.zone or task.zone) .. "' on this client."
        end
        return { mapID = mapID, x = d.x / 100, y = d.y / 100, title = task.title, approx = true, zone = d.zone or task.zone }
    end
    if task.zone then
        -- No spot known: while you are elsewhere, point at the zone itself
        -- (centre of its map) so the arrow leads you there; once inside the
        -- zone there is nothing more specific to point at.
        local cur = self:CurrentZone()
        if cur ~= task.zone then
            local mapID = self:MapIDForZone(task.zone)
            if mapID then
                return { mapID = mapID, x = 0.5, y = 0.5, title = "Travel to " .. task.zone, zone = task.zone,
                         zoneOnly = true, approx = true }
            end
        end
        return nil, (cur == task.zone and ("You are in " .. task.zone .. ": no exact spot needed (/ja mark saves one).")
            or ("No coordinates known in " .. task.zone .. ". Travel there and type /ja mark at a good spot to save it."))
    end
    return nil, "This task can be done anywhere."
end

-- Save the player's current position as a verified location for a task
-- (and, for zone-wide tasks like gathering, for the whole zone).
function RT:MarkCurrent(task)
    local mapID, x, y = self:PlayerPosition()
    if not (mapID and x and y) then
        ns.Print("Position unavailable here (instance or restricted area).")
        return
    end
    local info = C_Map.GetMapInfo(mapID)
    local zone = info and info.name
    local entry = { mapID = mapID, x = x, y = y, zone = zone, saved = time and time() or 0 }
    if task then
        ns.db.learnedLocations[task.id] = entry
        if task.kind == "gather" or task.kind == "fish" then
            ns.db.learnedLocations["zone:" .. (task.zone or zone or "?")] = entry
        end
        ns.Print(("Saved %s %.1f, %.1f for: %s"):format(zone or "?", x * 100, y * 100, task.title))
    else
        ns.db.learnedLocations["zone:" .. (zone or "?")] = entry
        ns.Print(("Saved %s %.1f, %.1f as this zone's default spot."):format(zone or "?", x * 100, y * 100))
    end
    ns:RequestRefresh("mark")
end

---------------------------------------------------------------------------
-- Route ordering
---------------------------------------------------------------------------
local KIND_ORDER = { rank = 1, obtain = 2, gather = 3, fish = 4, craft = 5, scan = 6, info = 7 }

-- tasks: list of actionable tasks (not done/skipped/blocked).
-- Returns new ordered list and the zone sequence.
function RT:Order(tasks, startZone)
    local anywhereReady, anywhereLater, byZone, zoneList = {}, {}, {}, {}
    for _, t in ipairs(tasks) do
        if t.zone then
            if not byZone[t.zone] then
                byZone[t.zone] = { tasks = {}, value = 0 }
                zoneList[#zoneList + 1] = t.zone
            end
            table.insert(byZone[t.zone].tasks, t)
            byZone[t.zone].value = byZone[t.zone].value + (t.value or 1)
        elseif t.waitingFor and #t.waitingFor > 0 then
            anywhereLater[#anywhereLater + 1] = t
        else
            anywhereReady[#anywhereReady + 1] = t
        end
    end

    local function byKindValue(a, b)
        local ka, kb = KIND_ORDER[a.kind] or 9, KIND_ORDER[b.kind] or 9
        if ka ~= kb then return ka < kb end
        return (a.value or 0) > (b.value or 0)
    end

    local out, seq = {}, {}
    table.sort(anywhereReady, byKindValue)
    for _, t in ipairs(anywhereReady) do out[#out + 1] = t end

    local here = startZone
    local remaining = {}
    for _, z in ipairs(zoneList) do remaining[z] = true end
    while next(remaining) do
        local best, bestScore
        for z in pairs(remaining) do
            local d = self:Distance(here, z)
            local score = byZone[z].value / (1 + d)
            if not bestScore or score > bestScore then best, bestScore = z, score end
        end
        remaining[best] = nil
        seq[#seq + 1] = best
        table.sort(byZone[best].tasks, byKindValue)
        for _, t in ipairs(byZone[best].tasks) do out[#out + 1] = t end
        here = best
    end

    table.sort(anywhereLater, byKindValue)
    for _, t in ipairs(anywhereLater) do out[#out + 1] = t end
    return out, seq
end
