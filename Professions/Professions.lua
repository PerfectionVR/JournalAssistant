-- Journal Assistant - Profession detection
--
-- Forever shares the Mainline UI/API family, so the primary source is
-- GetProfessions()/GetProfessionInfo(). Because Forever re-adds First Aid (which
-- Retail removed), detection also tries, in order:
--   2. the Classic skill-line API (GetNumSkillLines/GetSkillLineInfo) if present,
--   3. C_TradeSkillUI.GetProfessionInfoBySkillLineID for known skill lines,
--   4. values seen while a profession window was open (cached per character).
-- `/ja debug` reports which source supplied each profession.

local _, ns = ...
local P = {}
ns.Professions = P

P.list = {}
P.byKey = {}
P.sourcesTried = {}

-- Lookup tables built from the per-profession data (Data/Professions/<Name>.lua)
P.SKILL_LINES, P.KIND, P.DISPLAY = {}, {}, {}
local NAME_KEYS, ICONS, ORDER = {}, {}, {}
for key, info in pairs(ns.Data.professionInfo or {}) do
    if info.skillLine then P.SKILL_LINES[info.skillLine] = key end
    P.KIND[key], P.DISPLAY[key], ICONS[key], ORDER[key] = info.kind, info.name, info.icon, info.order
    NAME_KEYS[string.lower(info.name)] = key
    for _, alias in ipairs(info.aliases or {}) do NAME_KEYS[string.lower(alias)] = key end
    ns:RegisterCategory(key, info.name, info.icon)
end

function P:KeyFor(skillLine, name)
    if skillLine and P.SKILL_LINES[skillLine] then return P.SKILL_LINES[skillLine] end
    if name then
        local k = NAME_KEYS[string.lower(name)]
        if k then return k end
        -- Localised / renamed clients: partial match as a last resort.
        local lname = string.lower(name)
        for pattern, key in pairs(NAME_KEYS) do
            if lname:find(pattern, 1, true) then return key end
        end
    end
    return nil
end

local function packed(ok, ...)
    return ok, { n = select("#", ...), ... }
end

local function makeRecord(key, name, icon, skill, maxSkill, modifier, skillLine, source)
    return {
        key = key,
        name = name or P.DISPLAY[key] or key,
        icon = icon or ICONS[key] or "Interface\\Icons\\INV_Misc_QuestionMark",
        skill = tonumber(skill) or 0,
        maxSkill = tonumber(maxSkill) or 0,
        modifier = tonumber(modifier) or 0,
        skillLine = skillLine,
        kind = P.KIND[key] or "craft",
        source = source,
    }
end

function P:Scan()
    local found = {}
    local tried = {}

    local function add(rec)
        if not rec or not rec.key or rec.maxSkill <= 0 then return end
        local ex = found[rec.key]
        if not ex or rec.maxSkill > ex.maxSkill or (rec.maxSkill == ex.maxSkill and rec.skill > ex.skill) then
            found[rec.key] = rec
        end
    end

    -- 1. Mainline profession API
    if type(GetProfessions) == "function" and type(GetProfessionInfo) == "function" then
        local ok, idx = packed(pcall(GetProfessions))
        tried[#tried + 1] = "GetProfessions:" .. (ok and "ok" or "error")
        if ok then
            for i = 1, idx.n do
                local index = idx[i]
                if index then
                    local okI, name, icon, rank, maxRank, _, _, skillLine, rankModifier = pcall(GetProfessionInfo, index)
                    if okI and name then
                        local key = P:KeyFor(skillLine, name)
                        if key then add(makeRecord(key, name, icon, rank, maxRank, rankModifier, skillLine, "GetProfessionInfo")) end
                    end
                end
            end
        end
    else
        tried[#tried + 1] = "GetProfessions:missing"
    end

    -- 2. Classic skill-line API (only exists on some clients)
    if type(GetNumSkillLines) == "function" and type(GetSkillLineInfo) == "function" then
        local okN, n = pcall(GetNumSkillLines)
        tried[#tried + 1] = "GetSkillLineInfo:" .. (okN and tostring(n) or "error")
        if okN and n then
            for i = 1, n do
                local okI, name, isHeader, _, rank, _, modifier, maxRank = pcall(GetSkillLineInfo, i)
                if okI and name and not isHeader then
                    local key = P:KeyFor(nil, name)
                    if key then add(makeRecord(key, name, nil, rank, maxRank, modifier, nil, "GetSkillLineInfo")) end
                end
            end
        end
    end

    -- 3. Per-skill-line probe (catches First Aid if GetProfessions omits it)
    if ns.Has("C_TradeSkillUI", "GetProfessionInfoBySkillLineID") then
        local probed = 0
        for skillLine, key in pairs(P.SKILL_LINES) do
            if not found[key] then
                local ok, info = pcall(C_TradeSkillUI.GetProfessionInfoBySkillLineID, skillLine)
                if ok and type(info) == "table" and (info.skillLevel or 0) > 0 and (info.maxSkillLevel or 0) > 0 then
                    add(makeRecord(key, info.professionName, nil, info.skillLevel, info.maxSkillLevel,
                        info.skillModifier, skillLine, "GetProfessionInfoBySkillLineID"))
                    probed = probed + 1
                end
            end
        end
        tried[#tried + 1] = "BySkillLineID:" .. probed
    end

    -- 4. Values cached from an open profession window
    for key, c in pairs(ns.char.profCache) do
        if c.fromTradeWindow then
            local ex = found[key]
            if not ex then
                add(makeRecord(key, c.name, c.icon, c.skill, c.maxSkill, 0, c.skillLine, "TradeSkillWindow(cache)"))
            elseif (c.maxSkill or 0) > ex.maxSkill or ((c.maxSkill or 0) == ex.maxSkill and (c.skill or 0) > ex.skill) then
                -- a newer window reading beats a stale API value
                if (c.time or 0) > (P.lastScanTime or 0) - 5 then
                    ex.skill, ex.maxSkill = c.skill, c.maxSkill
                end
            end
        end
    end

    -- Diff against previous scan for change notifications.
    local list = {}
    for key, rec in pairs(found) do
        local prev = P.byKey[key]
        if prev and (prev.skill ~= rec.skill or prev.maxSkill ~= rec.maxSkill) then
            ns:Fire("SKILL_CHANGED", key, prev, rec)
        end
        local cache = ns.char.profCache[key] or {}
        cache.name, cache.icon, cache.skillLine = rec.name, rec.icon, rec.skillLine
        if not cache.fromTradeWindow or rec.skill >= (cache.skill or 0) then
            cache.skill, cache.maxSkill = rec.skill, rec.maxSkill
        end
        ns.char.profCache[key] = cache
        list[#list + 1] = rec
    end
    table.sort(list, function(a, b) return (ORDER[a.key] or 99) < (ORDER[b.key] or 99) end)

    P.list, P.byKey, P.sourcesTried = list, found, tried
    P.lastScanTime = GetTime and GetTime() or 0
    return list
end

-- Called by Recipes when a profession window reports its own skill values.
function P:UpdateFromTradeWindow(key, name, skill, maxSkill, skillLine)
    if not key or not skill or not maxSkill or maxSkill <= 0 then return end
    local c = ns.char.profCache[key] or {}
    c.name = name or c.name
    c.skill, c.maxSkill = skill, maxSkill
    c.skillLine = skillLine or c.skillLine
    c.fromTradeWindow = true
    c.time = GetTime and GetTime() or 0
    ns.char.profCache[key] = c
end

function P:Get(key) return P.byKey[key] end

function P:Icon(key) return ICONS[key] end

function P:IsPaused(key)
    return key and ns.char.disabledProfs and ns.char.disabledProfs[key] and true or false
end

---------------------------------------------------------------------------
-- Targets and pausing
---------------------------------------------------------------------------
ns.TARGET_STEPS = { 75, 150, 225, 300, 375, 450 }

function ns:GetTarget(key)
    return (ns.char and ns.char.targets[key]) or (ns.char and ns.char.defaultTarget) or 225
end

function ns:SetTarget(key, value)
    value = tonumber(value)
    if not value then return end
    ns.char.targets[key] = ns.Clamp(math.floor(value), 1, 1000)
    ns:RequestRefresh("target")
end

function ns:StepTarget(key, dir)
    local cur = ns:GetTarget(key)
    local steps = ns.TARGET_STEPS
    if dir > 0 then
        for i = 1, #steps do
            if steps[i] > cur then return ns:SetTarget(key, steps[i]) end
        end
    else
        for i = #steps, 1, -1 do
            if steps[i] < cur then return ns:SetTarget(key, steps[i]) end
        end
    end
end

function ns:TogglePaused(key)
    ns.char.disabledProfs[key] = not ns.char.disabledProfs[key] or nil
    local name = ns:CategoryName(key)
    ns.Print(name .. (ns.char.disabledProfs[key] and (": " .. ns.GREY .. "paused|r - nothing is planned for it.") or (": " .. ns.GREEN .. "on|r")))
    ns:RequestRefresh("pause")
end

-- saved settings of this module
ns:RegisterDefaults("char", {
    defaultTarget = 225,
    targets = {},          -- [profKey] = number
    recipes = {},          -- [profKey] = recipe cache from trade skill scans
    profCache = {},        -- [profKey] = last known skill info (fallback)
    disabledProfs = {},    -- [profKey] = true: profession paused, nothing is planned for it
})

-- skill changes trigger a refresh
for _, e in ipairs({ "SKILL_LINES_CHANGED", "CHAT_MSG_SKILL", "LEARNED_SPELL_IN_TAB", "LEARNED_SPELL_IN_SKILL_LINE", "TRADE_SKILL_CLOSE" }) do
    ns:RegisterEvent(e, function(ev) ns:RequestRefresh(ev) end)
end

-- diagnostics: /ja debug
ns.Diagnostics:AddSection("Profession detection", function(add)
    add("  Sources tried: " .. table.concat(P.sourcesTried or {}, ", "))
    for _, p in ipairs(P.list) do
        add(("  %-14s %3d/%3d  key=%s skillLine=%s source=%s target=%d"):format(p.name, p.skill, p.maxSkill, p.key,
            tostring(p.skillLine), tostring(p.source), ns:GetTarget(p.key)))
    end
    if #P.list == 0 then add("  (none detected)") end
end)

-- slash commands
local function FindProf(word)
    if not word or word == "" then return nil end
    word = word:lower()
    for _, p in ipairs(P.list) do
        if p.key:lower() == word or p.name:lower():find(word, 1, true) then return p end
    end
end

ns:AddCommand("target", function(rest)
    local word, value = rest:match("^(.-)%s+(%d+)$")
    local p = FindProf(word)
    if p and value then
        ns:SetTarget(p.key, tonumber(value))
        ns.Print(("%s target set to %s"):format(p.name, value))
    else
        ns.Print("Usage: /ja target <profession> <value>")
    end
end, "/ja target <profession> <value> - e.g. /ja target alchemy 300")
ns:AddCommand({ "pause", "resume" }, function(rest)
    local p = FindProf(rest)
    if p then ns:TogglePaused(p.key) else ns.Print("Usage: /ja pause <profession>  (again to switch it back on)") end
end, "/ja pause <profession> - switch a profession off/on (paused = no tasks)")
ns:AddCommand("rescan", function()
    P:Scan()
    ns:Refresh()
    ns.Print(("Rescanned: %d professions detected."):format(#P.list))
end)

-- public API addition (JournalAssistantAPI.GetProfessions)
ns.publicAPI = ns.publicAPI or {}
ns.publicAPI.GetProfessions = function()
    local out = {}
    for _, p in ipairs(P.list) do
        out[#out + 1] = { key = p.key, name = p.name, skill = p.skill, maxSkill = p.maxSkill, target = ns:GetTarget(p.key) }
    end
    return out
end
