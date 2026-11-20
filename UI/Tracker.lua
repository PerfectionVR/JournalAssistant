-- Journal Assistant - Small on-screen tracker (separate from the dashboard)
-- Shows the active task, its progress and the built-in navigation guidance.
-- Drag to move (unless locked). Left-click opens the dashboard, right-click = next task.

local _, ns = ...
local T = ns.Theme
local C = T.colors
local TR = {}
ns.Tracker = TR

local f, ticker

local function Save()
    local point, _, _, x, y = f:GetPoint()
    ns.db.tracker.point, ns.db.tracker.x, ns.db.tracker.y = point, x, y
end

function TR:Create()
    if f then return f end
    f = T.Panel(UIParent, "JA_Tracker")
    f:SetSize(250, 62)
    local p = ns.db.tracker
    f:SetPoint(p.point or "TOPRIGHT", UIParent, p.point or "TOPRIGHT", p.x or -230, p.y or -240)
    f:SetFrameStrata("LOW")
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        self.dragging = true
        if not ns.db.lockTracker then self:StartMoving() end
    end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); Save() end)
    f:SetScript("OnMouseUp", function(self, btn)
        if self.dragging then self.dragging = false; return end
        if btn == "RightButton" then ns.Planner:SelectNext() else ns.UI:Toggle() end
    end)
    f:SetScript("OnEnter", function(self) ns.UI.TaskTooltip(self, ns.Planner.active, "ANCHOR_LEFT") end)
    f:SetScript("OnLeave", function() GameTooltip:Hide() end)

    f.icon = f:CreateTexture(nil, "ARTWORK")
    f.icon:SetSize(16, 16)
    f.icon:SetPoint("TOPLEFT", 6, -6)
    f.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    f.arrow = T.Button(f, "Arrow", 44, 15, function() ns.Navigation:ToggleArrow() end,
        "Quick toggle: the TomTom arrow (or map pin) follows the active task")
    f.arrow:SetPoint("TOPRIGHT", -5, -5)
    f.title = T.Text(f, 11, C.gold)
    f.title:SetPoint("TOPLEFT", 26, -7)
    f.title:SetPoint("RIGHT", f.arrow, "LEFT", -4, 0)
    f.bar = T.Bar(f, 4)
    f.bar:SetPoint("TOPLEFT", 6, -27)
    f.bar:SetPoint("RIGHT", -6, 0)
    f.progress = T.Text(f, 10, C.text)
    f.progress:SetPoint("TOPLEFT", 6, -35)
    f.progress:SetPoint("RIGHT", -6, 0)
    f.guide = T.Text(f, 10, C.green)
    f.guide:SetPoint("TOPLEFT", 6, -48)
    f.guide:SetPoint("RIGHT", -6, 0)
    return f
end

function TR:Refresh()
    if not ns.db.showTracker then
        if f then f:Hide() end
        TR:StopTicker()
        return
    end
    TR:Create()
    f.arrow.text:SetTextColor(unpack(ns.db.arrowMode and C.green or C.dim))
    f.arrow:SetLabel(ns.db.arrowMode and "Arrow" or "Arrow")
    local t = ns.Planner.active
    if not t then
        f.icon:SetTexture("Interface\\Icons\\Achievement_Profession_ChefHat")
        f.title:SetText("All goals complete")
        f.bar:SetValue(1)
        f.progress:SetText("")
        f.guide:SetText("")
    else
        local icon = t.prof and ns.categoryIcons[t.prof]
        f.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_Bag_10")
        f.title:SetText(t.title)
        f.bar:SetValue(t.progress or 0)
        f.progress:SetText(t.progressText or "")
        f.guide:SetText(ns.Navigation:GuidanceText())
    end
    f:Show()
    TR:StartTicker()
end

-- Distance text refresh: 2x per second, only while the tracker is visible and
-- the active destination has coordinates.
function TR:StartTicker()
    if ticker or not C_Timer.NewTicker then return end
    ticker = C_Timer.NewTicker(0.5, function()
        if not f or not f:IsShown() then return end
        if ns.Navigation.current then f.guide:SetText(ns.Navigation:GuidanceText()) end
    end)
end

function TR:StopTicker()
    if ticker then ticker:Cancel(); ticker = nil end
end

function TR:SetShown(on)
    ns.db.showTracker = on and true or false
    TR:Refresh()
end
