-- Journal Assistant - Trainer scanning
--
-- Whenever you open a profession trainer, JA records (account-wide) what that
-- trainer teaches, the skill each recipe needs, and where the trainer stands
-- (your position). This replaces guesses with what Forever's trainers really
-- teach: recipes are pointed at a trainer seen teaching them, and trainers seen
-- NOT teaching a recipe are never suggested for it again.

local _, ns = ...
local TR = {}
ns.Trainers = TR

local function lower(s) return s and string.lower(s) or nil end

function TR:Data()
    ns.db.trainerData = ns.db.trainerData or {}
    return ns.db.trainerData
end

function TR:Scan()
    if type(GetNumTrainerServices) ~= "function" or type(GetTrainerServiceInfo) ~= "function" then return end
    local npc = UnitName and UnitName("npc")
    if not npc then return end
    local okN, n = pcall(GetNumTrainerServices)
    if not okN or not n or n == 0 then return end
    local services, profName = {}, nil
    for i = 1, n do
        local ok, name, _, category = pcall(GetTrainerServiceInfo, i)
        if ok and name and category ~= "header" then
            local req, reqProf
            if type(GetTrainerServiceSkillReq) == "function" then
                local okR, skillName, rank = pcall(GetTrainerServiceSkillReq, i)
                if okR and skillName then reqProf, req = skillName, tonumber(rank) end
            end
            profName = profName or reqProf
            services[lower(name)] = { name = name, req = req, category = category }
        end
    end
    if not next(services) then return end
    local key = ns.Professions:KeyFor(nil, profName)
    local mapID, x, y = ns.Routes:PlayerPosition()
    local zone = ns.Routes:CurrentZone()
    local d = self:Data()
    d[npc] = { npc = npc, prof = key, profName = profName, services = services, zone = zone,
               mapID = mapID, x = x and x * 100, y = y and y * 100, faction = ns.PlayerFaction(),
               time = time and time() or 0 }
    local count = 0
    for _ in pairs(services) do count = count + 1 end
    ns.Debug("trainer scanned", npc, key, count)
    ns:RequestRefresh("trainer")
end

-- Trainers (this faction) seen for a profession
function TR:ForProfession(profKey)
    local out = {}
    for _, t in pairs(self:Data()) do
        if t.prof == profKey and (not t.faction or t.faction == ns.PlayerFaction()) then out[#out + 1] = t end
    end
    return out
end

-- returns teacher (trainer seen teaching it, with .req), visitedNames (trainers
-- of this profession seen NOT teaching it)
function TR:WhoTeaches(profKey, recipeName)
    local lname = lower(recipeName)
    local teacher, notHere = nil, {}
    for _, t in ipairs(self:ForProfession(profKey)) do
        local s = t.services[lname]
        if s then
            if not teacher then teacher = { trainer = t, req = s.req, category = s.category } end
        else
            notHere[t.npc] = true
        end
    end
    return teacher, notHere
end

-- trainer window: record what this trainer teaches (throttled)
local pending = false
for _, e in ipairs({ "TRAINER_SHOW", "TRAINER_UPDATE" }) do
    ns:RegisterEvent(e, function()
        if not ns.ready or pending then return end
        pending = true
        C_Timer.After(0.3, function() pending = false; TR:Scan() end)
    end)
end

ns.Diagnostics:AddSection("Trainers seen", function(add)
    local any = false
    for npc, t in pairs(TR:Data()) do
        local n = 0
        for _ in pairs(t.services or {}) do n = n + 1 end
        add(("  %s (%s, %s): %d services"):format(npc, tostring(t.profName), tostring(t.zone), n))
        any = true
    end
    if not any then add("  none yet - open a profession trainer's window") end
end)
