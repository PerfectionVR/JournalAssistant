-- Journal Assistant - Recipe scanning
--
-- Recipe data comes ONLY from your client: open a profession window once and
-- every recipe (learned and unlearned), its difficulty colour and reagents are
-- cached per character. The planner then works while the window is closed.
-- Supports the Mainline C_TradeSkillUI API (expected on Forever) and the
-- classic GetTradeSkillInfo API as a fallback.

local _, ns = ...
local R = {}
ns.Recipes = R

local DIFF_BY_ENUM = { [0] = "optimal", [1] = "medium", [2] = "easy", [3] = "trivial" }
local DIFF_ORDER = { "optimal", "medium", "easy", "trivial" }
local DIFF_INDEX = { optimal = 1, medium = 2, easy = 3, trivial = 4, difficult = 1 }

R.GAIN = { optimal = 1.0, medium = 0.6, easy = 0.25, trivial = 0 }
R.lastScan = nil

function R:Get(key) return ns.char.recipes[key] end

-- Recipe colours drift as skill rises. Without an open window we cannot ask the
-- client, so estimate: one colour step per ~12 points gained since the scan.
function R:EffectiveDifficulty(diff, staleBy)
    local idx = DIFF_INDEX[diff] or 4
    if staleBy and staleBy > 0 then
        idx = math.min(4, idx + math.floor(staleBy / 12))
    end
    return DIFF_ORDER[idx]
end

local function isVendorReagent(name)
    if not name then return false end
    for _, p in ipairs(ns.Data.vendorReagentPatterns or {}) do
        if name:find(p, 1, true) then return true end
    end
    return false
end
R.IsVendorReagent = isVendorReagent

---------------------------------------------------------------------------
-- Mainline scan
---------------------------------------------------------------------------
local function ScanModern()
    local T = C_TradeSkillUI
    if T.IsTradeSkillLinked and T.IsTradeSkillLinked() then return nil, "linked profession (not yours)" end
    if T.IsTradeSkillGuild and T.IsTradeSkillGuild() then return nil, "guild profession view" end
    if T.IsNPCCrafting and T.IsNPCCrafting() then return nil, "NPC crafting" end

    local base = T.GetBaseProfessionInfo and T.GetBaseProfessionInfo()
    local child = T.GetChildProfessionInfo and T.GetChildProfessionInfo()
    local info = (child and child.professionName and (child.maxSkillLevel or 0) > 0) and child or base
    if not info or not info.professionName then return nil, "no profession info" end

    local key = ns.Professions:KeyFor(base and base.professionID or info.professionID, info.professionName)
        or ns.Professions:KeyFor(nil, base and base.professionName)
    if not key then return nil, "unknown profession " .. tostring(info.professionName) end

    local ids = T.GetAllRecipeIDs and T.GetAllRecipeIDs()
    if not ids or #ids == 0 then return nil, "no recipes yet (data still loading?)" end

    local list, nLearned = {}, 0
    for _, id in ipairs(ids) do
        local ok, r = pcall(T.GetRecipeInfo, id)
        if ok and r and not r.isDummyRecipe and not r.isRecraft then
            local entry = {
                name = r.name,
                learned = r.learned and true or false,
                diff = DIFF_BY_ENUM[r.relativeDifficulty] or (r.learned and "trivial" or nil),
                skillUps = r.numSkillUps,
                reagents = {},
            }
            if entry.learned then nLearned = nLearned + 1 end
            if T.GetRecipeSchematic then
                local okS, sch = pcall(T.GetRecipeSchematic, id, false)
                if okS and sch and sch.reagentSlotSchematics then
                    local basic = Enum and Enum.CraftingReagentType and Enum.CraftingReagentType.Basic
                    for _, slot in ipairs(sch.reagentSlotSchematics) do
                        local include = slot.required ~= false and (basic == nil or slot.reagentType == nil or slot.reagentType == basic)
                        local rg = include and slot.reagents and slot.reagents[1]
                        if rg and rg.itemID then
                            local rname = ns.Inventory.ItemName(rg.itemID)
                            ns.Inventory:LearnID(rname, rg.itemID)
                            entry.reagents[#entry.reagents + 1] = { itemID = rg.itemID, name = rname, qty = slot.quantityRequired or 1 }
                        end
                    end
                end
            end
            if not entry.learned and T.GetRecipeSourceText then
                local okT, txt = pcall(T.GetRecipeSourceText, id)
                if okT and type(txt) == "string" then entry.source = txt:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|n", " ") end
            end
            list[id] = entry
        end
    end

    return {
        key = key, api = "C_TradeSkillUI",
        name = info.professionName,
        skillLine = base and base.professionID,
        scannedSkill = info.skillLevel, scannedMax = info.maxSkillLevel,
        list = list, count = #ids, learnedCount = nLearned,
    }
end

---------------------------------------------------------------------------
-- Classic scan (fallback)
---------------------------------------------------------------------------
local function ScanClassic()
    local profName, rank, maxRank = GetTradeSkillLine()
    if not profName or profName == "UNKNOWN" then return nil, "no trade skill line" end
    local key = ns.Professions:KeyFor(nil, profName)
    if not key then return nil, "unknown profession " .. tostring(profName) end
    local list, n = {}, 0
    for i = 1, (GetNumTradeSkills() or 0) do
        local name, kind = GetTradeSkillInfo(i)
        if name and kind ~= "header" and kind ~= "subheader" then
            local id = name
            if GetTradeSkillRecipeLink then
                local link = GetTradeSkillRecipeLink(i)
                local num = link and tonumber(link:match("enchant:(%d+)"))
                if num then id = num end
            end
            local entry = { name = name, learned = true, diff = kind, reagents = {} }
            for j = 1, (GetTradeSkillNumReagents(i) or 0) do
                local rName, _, rCount = GetTradeSkillReagentInfo(i, j)
                local rLink = GetTradeSkillReagentItemLink and GetTradeSkillReagentItemLink(i, j)
                local rID = rLink and tonumber(rLink:match("item:(%d+)"))
                ns.Inventory:LearnID(rName, rID)
                entry.reagents[#entry.reagents + 1] = { itemID = rID, name = rName, qty = rCount or 1 }
            end
            list[id] = entry
            n = n + 1
        end
    end
    return { key = key, api = "GetTradeSkillInfo", name = profName, scannedSkill = rank, scannedMax = maxRank,
             list = list, count = n, learnedCount = n }
end

function R:ScanOpenWindow()
    local ok, data, why
    if ns.Has("C_TradeSkillUI", "GetAllRecipeIDs") then
        ok, data, why = pcall(ScanModern)
    elseif type(GetNumTradeSkills) == "function" then
        ok, data, why = pcall(ScanClassic)
    else
        R.lastScan = { ok = false, reason = "no recipe API found" }
        return
    end
    if not ok then
        R.lastScan = { ok = false, reason = tostring(data) }
        ns.Debug("recipe scan error", data)
        return
    end
    if not data then
        R.lastScan = { ok = false, reason = why }
        return
    end
    data.time = time and time() or 0
    ns.char.recipes[data.key] = data
    ns.Professions:UpdateFromTradeWindow(data.key, data.name, data.scannedSkill, data.scannedMax, data.skillLine)
    R.lastScan = { ok = true, key = data.key, count = data.count, learned = data.learnedCount, api = data.api }
    ns.Debug("scanned", data.key, data.count, "recipes via", data.api)
    ns:RequestRefresh("recipes")
end

-- Count learned / unlearned for UI.
function R:Summary(key)
    local c = self:Get(key)
    if not c then return nil end
    local learned, unlearned = 0, 0
    for _, r in pairs(c.list) do
        if r.learned then learned = learned + 1 else unlearned = unlearned + 1 end
    end
    return learned, unlearned, c
end

-- Throttled scan on trade skill events
local scanPending = false
function R:RequestScan()
    if scanPending then return end
    scanPending = true
    C_Timer.After(0.6, function()
        scanPending = false
        R:ScanOpenWindow()
    end)
end

-- profession window events: rescan the open window
for _, e in ipairs({ "TRADE_SKILL_SHOW", "TRADE_SKILL_LIST_UPDATE", "TRADE_SKILL_DATA_SOURCE_CHANGED", "TRADE_SKILL_UPDATE" }) do
    ns:RegisterEvent(e, function() if ns.ready then R:RequestScan() end end)
end

ns.Diagnostics:AddSection("Recipe caches", function(add)
    for key, c in pairs(ns.char.recipes) do
        local learned, unlearned = R:Summary(key)
        add(("  %-10s api=%s learned=%d unlearned=%d scannedAt=%s/%s"):format(key, tostring(c.api), learned or 0,
            unlearned or 0, tostring(c.scannedSkill), tostring(c.scannedMax)))
    end
    if R.lastScan then
        local s = R.lastScan
        add("  Last scan: " .. (s.ok and ("ok " .. tostring(s.key) .. " " .. tostring(s.count)) or ("failed: " .. tostring(s.reason))))
    end
end)
