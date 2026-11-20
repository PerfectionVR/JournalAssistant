-- Journal Assistant - Optional minimap button
-- Uses LibDBIcon if another addon already loaded it (so minimap-button managers
-- can collect it); otherwise a small self-contained button. Left-click toggles
-- the dashboard, right-click opens settings, drag to move around the minimap.

local _, ns = ...
local MM = {}
ns.Minimap = MM

local button, ldbIcon
local ICON = "Interface\\Icons\\Trade_Alchemy"

local function OnClick(btn)
    if btn == "LeftButton" and IsShiftKeyDown and IsShiftKeyDown() then
        ns.Navigation:ToggleArrow()
    elseif btn == "RightButton" then ns.Settings:Toggle() else ns.UI:Toggle() end
end

local function Tooltip(tt)
    tt:AddLine("Journal Assistant", 0.83, 0.69, 0.22)
    local t = ns.Planner.active
    if t then tt:AddLine("Next: " .. t.title, 1, 1, 1, true) end
    tt:AddLine("Left-click: dashboard   Right-click: settings", 0.6, 0.6, 0.6)
    tt:AddLine("Shift+Left-click: toggle arrow (" .. (ns.db.arrowMode and "on" or "off") .. ")", 0.6, 0.6, 0.6)
end

local function TryLDB()
    if not LibStub then return false end
    local LDB = LibStub("LibDataBroker-1.1", true)
    local DBI = LibStub("LibDBIcon-1.0", true)
    if not (LDB and DBI) then return false end
    local obj = LDB:NewDataObject("JournalAssistant", {
        type = "launcher", icon = ICON, label = "JA",
        OnClick = function(_, btn) OnClick(btn) end,
        OnTooltipShow = Tooltip,
    })
    ns.db.ldbIcon = ns.db.ldbIcon or {}
    ns.db.ldbIcon.hide = not ns.db.showMinimap
    DBI:Register("JournalAssistant", obj, ns.db.ldbIcon)
    ldbIcon = DBI
    return true
end

local function UpdatePosition()
    local angle = math.rad(ns.db.minimapAngle or 215)
    local r = (Minimap:GetWidth() / 2) + 6
    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * r, math.sin(angle) * r)
end

local function CreateOwn()
    button = CreateFrame("Button", "JA_MinimapButton", Minimap)
    button:SetSize(31, 31)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 1)
    icon:SetTexture(ICON)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    button:SetScript("OnClick", function(_, btn) OnClick(btn) end)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        Tooltip(GameTooltip)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    button:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            cx, cy = cx / scale, cy / scale
            local atan2 = math.atan2 or math.atan
            ns.db.minimapAngle = math.deg(atan2(cy - my, cx - mx)) % 360
            UpdatePosition()
        end)
    end)
    button:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
    UpdatePosition()
end

function MM:Init()
    if not TryLDB() then CreateOwn() end
    MM:Refresh()
end

function MM:Refresh()
    if ldbIcon then
        if ns.db.showMinimap then ldbIcon:Show("JournalAssistant") else ldbIcon:Hide("JournalAssistant") end
        ns.db.ldbIcon.hide = not ns.db.showMinimap
    elseif button then
        button:SetShown(ns.db.showMinimap)
    end
end

function MM:SetShown(on)
    ns.db.showMinimap = on and true or false
    MM:Refresh()
end
