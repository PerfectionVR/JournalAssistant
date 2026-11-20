-- Journal Assistant - Diagnostics (/ja debug)
-- Builds a plain-text compatibility report and shows it in a copyable window
-- (Ctrl+A, Ctrl+C) so it can be pasted into a bug report.

local _, ns = ...
local DG = {}
ns.Diagnostics = DG

local APIS = {
    { "GetBuildInfo" },
    { "GetProfessions" }, { "GetProfessionInfo" },
    { "GetNumSkillLines" }, { "GetSkillLineInfo" },
    { "C_TradeSkillUI", "GetAllRecipeIDs" }, { "C_TradeSkillUI", "GetRecipeInfo" },
    { "C_TradeSkillUI", "GetRecipeSchematic" }, { "C_TradeSkillUI", "GetBaseProfessionInfo" },
    { "C_TradeSkillUI", "GetChildProfessionInfo" }, { "C_TradeSkillUI", "GetProfessionInfoBySkillLineID" },
    { "C_TradeSkillUI", "GetRecipeSourceText" },
    { "GetTradeSkillLine" }, { "GetNumTradeSkills" }, { "GetTradeSkillInfo" },
    { "C_Container", "GetContainerItemInfo" }, { "C_Item", "GetItemCount" }, { "C_Item", "GetItemNameByID" },
    { "C_Map", "GetBestMapForUnit" }, { "C_Map", "GetPlayerMapPosition" }, { "C_Map", "GetMapInfo" },
    { "C_Map", "GetMapWorldSize" }, { "C_Map", "SetUserWaypoint" }, { "C_Map", "CanSetUserWaypointOnMap" },
    { "UiMapPoint", "CreateFromCoordinates" },
    { "C_SuperTrack", "SetSuperTrackedUserWaypoint" }, { "C_SuperTrack", "IsSuperTrackingAnything" },
    { "Settings", "RegisterCanvasLayoutCategory" }, { "C_AddOns", "IsAddOnLoaded" },
    { "C_Timer", "NewTicker" },
}

local KNOWN_ADDONS = {
    "TomTom", "Questie", "QuestieDB", "QuestieTrace", "HandyNotes", "HandyNotes_MapNotes",
    "ForeverNodes", "Forever Nodes", "ProfessionGuide", "FishFry", "Mealbook", "Auctionator",
    "Plumber", "WhatsTraining", "EllesmereUI", "DialogueUI", "BugSack", "BugGrabber",
}

local function AddOnList()
    local out = {}
    local num = (C_AddOns and C_AddOns.GetNumAddOns and C_AddOns.GetNumAddOns()) or (GetNumAddOns and GetNumAddOns()) or 0
    local info = (C_AddOns and C_AddOns.GetAddOnInfo) or GetAddOnInfo
    for i = 1, num do
        local name, title = info(i)
        if name then out[#out + 1] = { name = name, title = title and title:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") or name } end
    end
    return out
end

-- Modules add their own report sections: DG:AddSection(title, fn(add))
local sections = {}
function DG:AddSection(title, fn)
    sections[#sections + 1] = { title = title, fn = fn }
end

function DG:Report()
    local L = {}
    local function add(s) L[#L + 1] = s end
    add("=== Journal Assistant " .. ns.version .. " diagnostics ===")
    if GetBuildInfo then
        local v, build, date, toc = GetBuildInfo()
        add(("Client: %s (build %s, %s)  Interface: %s"):format(tostring(v), tostring(build), tostring(date), tostring(toc)))
    end
    add("WOW_PROJECT_ID: " .. tostring(WOW_PROJECT_ID) .. "   Locale: " .. tostring(GetLocale and GetLocale()))
    add(("Player: level %d %s   Zone: %s"):format(ns.PlayerLevel(), ns.PlayerFaction(), tostring(ns.Routes:CurrentZone())))
    add("")
    add("-- APIs --")
    for _, a in ipairs(APIS) do
        add(("  %-48s %s"):format(table.concat(a, "."), ns.Has(unpack(a)) and "yes" or "MISSING"))
    end
    add("")
    add("-- Navigation --")
    local st = ns.Navigation:ProviderStatus()
    add(("  TomTom API: %s   Map pin API: %s   SuperTrack: %s"):format(st.tomtom and "yes" or "no",
        st.blizzard and "yes" or "no", st.superTrack and "yes" or "no"))
    if ns.IsAddOnLoaded("TomTom") then
        local meta = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
        add("  TomTom version: " .. tostring(meta and meta("TomTom", "Version")))
    end
    add("  Follow The Arrow detected as: " .. tostring(st.fta or "not found by known folder names"))
    add("  Auto navigation: " .. tostring(ns.db.autoNav) .. "   provider pref: " .. tostring(ns.db.navProvider)
        .. "   owned: " .. tostring(ns.Navigation.owned.provider))
    if ns.Navigation.lastMessage then add("  Last nav message: " .. ns.Navigation.lastMessage) end
    ns.Routes:BuildMapIndex()
    add("  Zone map index: " .. tostring(ns.Routes.mapIndexCount) .. " zones; Arathi Highlands -> "
        .. tostring(ns.Routes:MapIDForZone("Arathi Highlands")) .. ", Stormwind City -> "
        .. tostring(ns.Routes:MapIDForZone("Stormwind City")))
    local saved = 0
    for _ in pairs(ns.db.learnedLocations) do saved = saved + 1 end
    add("  Saved (verified) locations: " .. saved)
    add("")
    add("-- Related addons (read-only detection, no data is modified) --")
    local list = AddOnList()
    local found = {}
    for _, a in ipairs(list) do
        local lname = (a.name .. " " .. a.title):lower()
        local interesting = lname:find("arrow") or lname:find("forever") or lname:find("profession")
            or lname:find("tomtom") or lname:find("questie") or lname:find("handynotes")
        for _, k in ipairs(KNOWN_ADDONS) do if a.name == k then interesting = true end end
        if interesting then
            found[#found + 1] = ("  %s%s [%s]"):format(a.name, a.title ~= a.name and (" (" .. a.title .. ")") or "",
                ns.IsAddOnLoaded(a.name) and "loaded" or "not loaded")
        end
    end
    for _, s in ipairs(found) do add(s) end
    add("")
    for _, sec in ipairs(sections) do
        add("-- " .. sec.title .. " --")
        local ok, err = pcall(sec.fn, add)
        if not ok then add("  (failed: " .. tostring(err) .. ")") end
        add("")
    end
    add("-- Planner --")
    add(("  Tasks: %d active, %d blocked, %d done, %d skipped. Active: %s"):format(#ns.Planner.ordered, #ns.Planner.blocked,
        #ns.Planner.doneList, #ns.Planner.skippedList, ns.Planner.active and ns.Planner.active.title or "none"))
    local failed = {}
    for e in pairs(ns.failedEvents) do failed[#failed + 1] = e end
    add("  Events not available on this client: " .. (#failed > 0 and table.concat(failed, ", ") or "none"))
    if ns.lastError then add("  Last error: " .. tostring(ns.lastError)) end
    return table.concat(L, "\n")
end

local win
function DG:Show()
    local T = ns.Theme -- UI loads after Core
    local text = self:Report()
    if not win then
        win = T.Panel(UIParent, "JA_DebugWindow")
        win:SetSize(620, 420)
        win:SetPoint("CENTER")
        win:SetFrameStrata("DIALOG")
        win:SetMovable(true)
        win:EnableMouse(true)
        win:RegisterForDrag("LeftButton")
        win:SetScript("OnDragStart", win.StartMoving)
        win:SetScript("OnDragStop", win.StopMovingOrSizing)
        table.insert(UISpecialFrames, "JA_DebugWindow")
        local title = T.Text(win, 12, T.colors.gold)
        title:SetPoint("TOPLEFT", 10, -8)
        title:SetText("JA diagnostics - Ctrl+A, Ctrl+C to copy")
        local close = T.Button(win, "x", 18, 16, function() win:Hide() end)
        close:SetPoint("TOPRIGHT", -6, -6)
        local sf = T.Scroll(win)
        sf:SetPoint("TOPLEFT", 10, -30)
        sf:SetPoint("BOTTOMRIGHT", -10, 10)
        local eb = CreateFrame("EditBox", nil, sf.content)
        eb:SetMultiLine(true)
        eb:SetAutoFocus(false)
        eb:SetFontObject(ChatFontNormal or GameFontHighlightSmall)
        eb:SetPoint("TOPLEFT")
        eb:SetWidth(590)
        eb:SetScript("OnEscapePressed", function() win:Hide() end)
        eb:SetScript("OnTextChanged", function(self, user)
            if user then self:SetText(win.text) end -- read-only
            sf.content:SetHeight(self:GetHeight())
        end)
        win.eb = eb
    end
    win.text = text
    win.eb:SetText(text)
    win.eb:HighlightText()
    win:Show()
    win.eb:SetFocus()
end
