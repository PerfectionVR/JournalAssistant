-- Journal Assistant - Main dashboard (generic)
-- Next objective box (always visible), a tab row and a scrolling list.
-- Tabs are registered by modules: UI:AddTab{ key, label, order, setting?,
-- count = fn() -> text|number, render = fn(L) }. L offers place(frame, h),
-- header(text, b1, f1, b2, f2), label(text), tasks(list, state, groupMode).
-- Rows come from pools (UI:Pool(name, create)), reset on every refresh.
-- Compact mode shows only the Next objective box.

local _, ns = ...
local T = ns.Theme
local C = T.colors
local UI = {}
ns.UI = UI

local PAD = 8
local TITLE_H = 24
local NEXT_H = 118
local HEADER_H = 20
local TAB_H = 20

UI.tabs = {}
UI.tab = "PLAN"

function UI:AddTab(def)
    UI.tabs[#UI.tabs + 1] = def
    table.sort(UI.tabs, function(a, b) return (a.order or 50) < (b.order or 50) end)
end

-- row pools: pool:Next() returns the next free row (created on demand)
local pools = {}
function UI:Pool(name, create)
    local p = pools[name]
    if not p then
        p = { items = {}, used = 0, create = create }
        function p:Next()
            self.used = self.used + 1
            local r = self.items[self.used]
            if not r then r = self.create(); self.items[self.used] = r end
            return r
        end
        pools[name] = p
    end
    return p
end

local frame, scroll, content, nextBox
local headers, labels = {}, {}

---------------------------------------------------------------------------
-- Frame
---------------------------------------------------------------------------
local function SavePosition()
    local point, _, _, x, y = frame:GetPoint()
    local w = ns.db.window
    w.point, w.x, w.y = point, x, y
    if not ns.db.compact then w.w, w.h = frame:GetWidth(), frame:GetHeight() end
end

local function CreateNextBox(parent)
    local b = T.Panel(parent, nil, true)
    b:SetHeight(NEXT_H)
    b.label = T.Text(b, 9, C.gold)
    b.label:SetPoint("TOPLEFT", 8, -6)
    b.label:SetText("NEXT OBJECTIVE")
    b.prof = T.Text(b, 9, C.dim, "RIGHT")
    b.prof:SetPoint("TOPRIGHT", -8, -6)
    b.title = T.Text(b, 13, C.text)
    b.title:SetPoint("TOPLEFT", 8, -20)
    b.title:SetPoint("RIGHT", -8, 0)
    b.detail = T.Text(b, 10, C.dim)
    b.detail:SetPoint("TOPLEFT", 8, -38)
    b.detail:SetPoint("RIGHT", -8, 0)
    b.bar = T.Bar(b, 5)
    b.bar:SetPoint("TOPLEFT", 8, -54)
    b.bar:SetPoint("RIGHT", -8, 0)
    b.progress = T.Text(b, 10, C.text)
    b.progress:SetPoint("TOPLEFT", 8, -63)
    b.progress:SetPoint("RIGHT", -8, 0)
    b.guide = T.Text(b, 10, C.green)
    b.guide:SetPoint("TOPLEFT", 8, -77)
    b.guide:SetPoint("RIGHT", -8, 0)

    local x = 8
    local function btn(label, w, fn, tip)
        local bt = T.Button(b, label, w, 18, fn, tip)
        bt:SetPoint("BOTTOMLEFT", x, 6)
        x = x + w + 4
        return bt
    end
    b.nav = btn("Navigate", 60, function() ns.Navigation:Navigate(ns.Planner.active, true) end,
        "Set a waypoint for this task (TomTom if installed, otherwise the map pin).")
    b.done = btn("Done", 44, function() if ns.Planner.active then ns.Planner:SetDone(ns.Planner.active.id, true) end end,
        "Mark complete manually (it comes back if the planner still needs it after you gain skill).")
    b.skip = btn("Skip", 40, function() if ns.Planner.active then ns.Planner:Skip(ns.Planner.active.id) end end,
        "Ignore this recommendation (undo in the Skipped list).")
    b.next = btn("Next", 40, function() ns.Planner:SelectNext() end, "Make the next task in the route active.")
    b.mark = btn("Mark", 40, function() ns.Routes:MarkCurrent(ns.Planner.active) end,
        "Save your current position as this task's destination (verified location).")
    b.arrow = btn("Arrow", 60, function() ns.Navigation:ToggleArrow() end,
        "Quick toggle: the TomTom arrow (or the map pin if TomTom is missing) follows the active task.\n/ja arrow, or bind a key under Keybindings > AddOns.")
    b:SetScript("OnEnter", function(self) UI.TaskTooltip(self, ns.Planner.active) end)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
    return b
end

function UI:Create()
    if frame then return frame end
    local w = ns.db.window
    frame = T.Panel(UIParent, "JA_Dashboard")
    frame:SetFrameStrata("MEDIUM")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:SetResizable(true)
    if frame.SetResizeBounds then frame:SetResizeBounds(330, 200, 900, 1100)
    elseif frame.SetMinResize then frame:SetMinResize(330, 200) end
    frame:SetSize(w.w or 430, w.h or 540)
    frame:SetPoint(w.point or "CENTER", UIParent, w.point or "CENTER", w.x or 0, w.y or 0)
    frame:EnableMouse(true)
    frame:Hide()
    table.insert(UISpecialFrames, "JA_Dashboard") -- close with Escape

    -- title bar
    local bar = CreateFrame("Frame", nil, frame)
    bar:SetPoint("TOPLEFT")
    bar:SetPoint("TOPRIGHT")
    bar:SetHeight(TITLE_H)
    bar:EnableMouse(true)
    bar:RegisterForDrag("LeftButton")
    bar:SetScript("OnDragStart", function() frame:StartMoving() end)
    bar:SetScript("OnDragStop", function() frame:StopMovingOrSizing(); SavePosition() end)
    local title = T.Text(bar, 12, C.gold)
    title:SetPoint("LEFT", 10, 0)
    title:SetText("Journal Assistant")
    frame.subtitle = T.Text(bar, 9, C.dim)
    frame.subtitle:SetPoint("LEFT", title, "RIGHT", 8, -1)
    local line = T.Divider(frame)
    line:SetPoint("TOPLEFT", 0, -TITLE_H)
    line:SetPoint("TOPRIGHT", 0, -TITLE_H)

    local close = T.Button(bar, "x", 18, 16, function() frame:Hide() end, "Close (/ja)")
    close:SetPoint("RIGHT", -4, 0)
    local opts = T.Button(bar, "Options", 50, 16, function() ns.Settings:Toggle() end, "Settings")
    opts:SetPoint("RIGHT", close, "LEFT", -4, 0)
    frame.compactBtn = T.Button(bar, "Compact", 52, 16, function() UI:SetCompact(not ns.db.compact) end,
        "Show only the active task")
    frame.compactBtn:SetPoint("RIGHT", opts, "LEFT", -4, 0)

    nextBox = CreateNextBox(frame)
    nextBox:SetPoint("TOPLEFT", PAD, -(TITLE_H + PAD))
    nextBox:SetPoint("TOPRIGHT", -PAD, -(TITLE_H + PAD))

    -- tab row
    local tabBar = CreateFrame("Frame", nil, frame)
    tabBar:SetPoint("TOPLEFT", PAD, -(TITLE_H + PAD + NEXT_H + 4))
    tabBar:SetPoint("TOPRIGHT", -PAD, -(TITLE_H + PAD + NEXT_H + 4))
    tabBar:SetHeight(TAB_H)
    frame.tabBar = tabBar
    frame.tabs = {}
    for _, def in ipairs(UI.tabs) do
        local b = T.Button(tabBar, def.label, 60, TAB_H, function() UI:SelectTab(def.key) end)
        b.def = def
        b:HookScript("OnLeave", function() UI:RefreshTabs() end) -- keep the selected tab highlighted
        frame.tabs[#frame.tabs + 1] = b
    end

    scroll = T.Scroll(frame)
    scroll:SetPoint("TOPLEFT", PAD, -(TITLE_H + PAD + NEXT_H + 4 + TAB_H + 6))
    scroll:SetPoint("BOTTOMRIGHT", -PAD, PAD + 6)
    content = scroll.content
    UI.content = content

    local grip = CreateFrame("Button", nil, frame)
    grip:SetSize(14, 14)
    grip:SetPoint("BOTTOMRIGHT", -2, 2)
    grip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    grip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    grip:SetScript("OnMouseDown", function() if not ns.db.compact then frame:StartSizing("BOTTOMRIGHT") end end)
    grip:SetScript("OnMouseUp", function() frame:StopMovingOrSizing(); SavePosition(); UI:Refresh() end)
    frame.grip = grip

    frame:SetScript("OnShow", function() UI:Refresh() end)
    frame:SetScript("OnSizeChanged", function() if frame:IsShown() then UI:LayoutLater() end end)
    UI:SetCompact(ns.db.compact, true)
    return frame
end

function UI:SetCompact(on, silent)
    ns.db.compact = on and true or false
    if not frame then return end
    if on then
        scroll:Hide()
        frame.tabBar:Hide()
        frame.grip:Hide()
        frame:SetHeight(TITLE_H + PAD + NEXT_H + PAD)
        frame.compactBtn:SetLabel("Expand")
    else
        scroll:Show()
        frame.tabBar:Show()
        frame.grip:Show()
        frame:SetHeight(ns.db.window.h or 540)
        frame.compactBtn:SetLabel("Compact")
    end
    if not silent then UI:Refresh() end
end

function UI:Toggle()
    UI:Create()
    if frame:IsShown() then frame:Hide() else frame:Show() end
end

function UI:Show() UI:Create(); frame:Show() end

function UI:ResetPosition()
    ns.db.window = { point = "CENTER", x = 0, y = 40, w = 430, h = 540 }
    if frame then
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
        frame:SetSize(430, 540)
        UI:SetCompact(false)
    end
end

---------------------------------------------------------------------------
-- Rows
---------------------------------------------------------------------------
local function GetHeader(i)
    local h = headers[i]
    if h then return h end
    h = CreateFrame("Button", nil, content)
    h:SetHeight(HEADER_H)
    h.text = T.Text(h, 10, C.gold)
    h.text:SetPoint("LEFT", 2, 0)
    h.line = T.Divider(h)
    h.line:SetPoint("BOTTOMLEFT", 0, 1)
    h.line:SetPoint("BOTTOMRIGHT", 0, 1)
    h.right1 = T.Button(h, "", 70, 16)
    h.right1:SetPoint("RIGHT", 0, 0)
    h.right2 = T.Button(h, "", 70, 16)
    h.right2:SetPoint("RIGHT", h.right1, "LEFT", -4, 0)
    headers[i] = h
    return h
end

local function GetLabel(i)
    local l = labels[i]
    if l then return l end
    l = CreateFrame("Frame", nil, content)
    l:SetHeight(16)
    l.text = T.Text(l, 10, C.dim)
    l.text:SetPoint("LEFT", 2, 0)
    l.text:SetPoint("RIGHT", -2, 0)
    labels[i] = l
    return l
end

local layoutPending = false
function UI:LayoutLater()
    if layoutPending then return end
    layoutPending = true
    C_Timer.After(0.05, function() layoutPending = false; UI:Refresh() end)
end

function UI:RefreshNext()
    if not nextBox then return end
    nextBox.arrow:SetLabel(ns.db.arrowMode and "Arrow: ON" or "Arrow: off")
    nextBox.arrow.text:SetTextColor(unpack(ns.db.arrowMode and C.green or C.gold))
    local t = ns.Planner.active
    if not t then
        nextBox.prof:SetText("")
        local title, hint = nil, nil
        if UI.emptyHint then title, hint = UI.emptyHint() end
        nextBox.title:SetText(title or "All objectives done")
        nextBox.detail:SetText(hint or "Raise a target or switch something On to plan further, or check Skipped tasks.")
        nextBox.bar:SetValue(title and 0 or 1)
        nextBox.progress:SetText("")
        nextBox.guide:SetText("")
        return
    end
    nextBox.prof:SetText(UI.CategoryLabel(t.prof) .. (t.zone and ("  ·  " .. t.zone) or ""))
    nextBox.title:SetText(t.title)
    local firstLine = (t.detail or ""):match("^[^\n]*") or ""
    nextBox.detail:SetText(firstLine)
    nextBox.bar:SetValue(t.progress or 0)
    local p = t.progressText or ""
    local costText = UI.CostText(t)
    if costText then p = p .. (p ~= "" and "  ·  " or "") .. costText end
    if t.caution then p = p .. "   " .. ns.ORANGE .. "! " .. t.caution .. "|r" end
    nextBox.progress:SetText(p)
    local g = ns.Navigation:GuidanceText()
    local auto = ns.db.arrowMode and (ns.GREEN .. "Arrow ON|r")
        or (ns.db.autoNav and (ns.GREEN .. "Auto-nav ON|r") or (ns.GREY .. "Auto-nav off|r"))
    nextBox.guide:SetText(g .. (g ~= "" and "   " or "") .. auto)
    nextBox.nav:SetShown(t.zone ~= nil)
end

function UI:SelectTab(key)
    UI.tab = key
    if scroll then scroll:SetVerticalScroll(0) end
    if ns.db.compact then UI:SetCompact(false) else UI:Refresh() end
end

-- Lay out the visible tabs evenly and show counts
function UI:RefreshTabs()
    if not frame or not frame.tabs then return end
    local visible = {}
    for _, b in ipairs(frame.tabs) do
        local def = b.def
        local show = not def.setting or ns.db[def.setting]
        b:SetShown(show)
        if show then visible[#visible + 1] = b end
    end
    -- fall back to the plan if the selected tab was turned off
    local ok = false
    for _, b in ipairs(visible) do if b.def.key == UI.tab then ok = true end end
    if not ok then UI.tab = "PLAN" end
    local w = frame.tabBar:GetWidth()
    local gap = 3
    local bw = math.floor((w - gap * (#visible - 1)) / math.max(1, #visible))
    for i, b in ipairs(visible) do
        b:ClearAllPoints()
        b:SetPoint("TOPLEFT", frame.tabBar, "TOPLEFT", (i - 1) * (bw + gap), 0)
        b:SetWidth(bw)
        local key = b.def.key
        local count = b.def.count and b.def.count()
        b:SetLabel(b.def.label .. (count and (" " .. ns.GREY .. count .. "|r") or ""))
        local sel = key == UI.tab
        if b.SetBackdropColor then
            b:SetBackdropColor(unpack(sel and C.rowHi or { 0.10, 0.10, 0.11, 0.95 }))
            b:SetBackdropBorderColor(unpack(sel and C.gold or C.borderD))
        end
        b.text:SetTextColor(unpack(sel and C.text or C.gold))
    end
end

function UI:Refresh()
    if not frame or not frame:IsShown() then return end
    frame.subtitle:SetText(("Lv %d  ·  %s"):format(ns.PlayerLevel(), ns.Routes:CurrentZone() or ""))
    UI:RefreshNext()
    if ns.db.compact then return end

    content:SetWidth(scroll:GetWidth())
    local y, hi, li = 0, 0, 0
    for _, p in pairs(pools) do p.used = 0 end
    local L = {}
    function L.place(f, h)
        f:ClearAllPoints()
        f:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)
        f:SetPoint("RIGHT", content, "RIGHT", -6, 0)
        f:SetHeight(h)
        f:Show()
        y = y + h + 3
    end
    function L.header(text, b1, f1, b2, f2)
        hi = hi + 1
        local h = GetHeader(hi)
        h.text:SetText(text)
        h.right1:SetShown(b1 ~= nil); h.right2:SetShown(b2 ~= nil)
        if b1 then h.right1:SetLabel(b1); h.right1:SetScript("OnClick", f1) end
        if b2 then h.right2:SetLabel(b2); h.right2:SetScript("OnClick", f2) end
        h:SetScript("OnClick", nil)
        L.place(h, HEADER_H)
        return h
    end
    function L.label(text)
        li = li + 1
        local l = GetLabel(li)
        l.text:SetText(text)
        L.place(l, 16)
    end
    -- groupMode: guide-tab rows (On/Off switch instead of Done / Skip), no filter
    function L.tasks(list, state, groupMode)
        local n = 0
        for _, t in ipairs(list) do
            if groupMode or UI.PassesFilter(t) then
                local r = UI.taskPool:Next()
                UI.FillTaskRow(r, t, state, groupMode)
                L.place(r, UI.TASK_H)
                n = n + 1
            end
        end
        return n
    end

    UI:RefreshTabs() -- may fall back to the Plan tab if the selected one was turned off
    for _, def in ipairs(UI.tabs) do
        if def.key == UI.tab and def.render then def.render(L) end
    end

    for _, p in pairs(pools) do
        for i = p.used + 1, #p.items do p.items[i]:Hide() end
    end
    for i = hi + 1, #headers do headers[i]:Hide() end
    for i = li + 1, #labels do labels[i]:Hide() end
    content:SetHeight(math.max(y, 10))
    scroll:UpdateThumb()
end
