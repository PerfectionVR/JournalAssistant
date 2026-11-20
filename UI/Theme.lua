-- Journal Assistant - UI theme & widget helpers
-- Dark, understated panels with thin gold accents. No XML, no external libs.

local _, ns = ...
local T = {}
ns.Theme = T

T.colors = {
    bg      = { 0.035, 0.035, 0.04, 0.94 },
    bgAlt   = { 0.07, 0.07, 0.075, 0.9 },
    row     = { 0.09, 0.09, 0.095, 0.85 },
    rowHi   = { 0.16, 0.14, 0.09, 0.9 },
    border  = { 0.83, 0.69, 0.22, 0.45 },
    borderD = { 0.25, 0.22, 0.15, 0.8 },
    gold    = { 0.83, 0.69, 0.22, 1 },
    text    = { 0.88, 0.87, 0.84, 1 },
    dim     = { 0.55, 0.54, 0.52, 1 },
    bar     = { 0.80, 0.64, 0.20, 1 },
    barBg   = { 0.14, 0.13, 0.12, 1 },
    green   = { 0.45, 0.75, 0.45, 1 },
    red     = { 0.82, 0.32, 0.32, 1 },
    orange  = { 0.90, 0.55, 0.22, 1 },
}

local WHITE = "Interface\\Buttons\\WHITE8x8"
T.WHITE = WHITE

function T.Panel(parent, name, alt)
    local f = CreateFrame("Frame", name, parent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    if f.SetBackdrop then
        f:SetBackdrop({ bgFile = WHITE, edgeFile = WHITE, edgeSize = 1 })
        f:SetBackdropColor(unpack(alt and T.colors.bgAlt or T.colors.bg))
        f:SetBackdropBorderColor(unpack(alt and T.colors.borderD or T.colors.border))
    else
        local bg = f:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(unpack(alt and T.colors.bgAlt or T.colors.bg))
    end
    return f
end

function T.Text(parent, size, color, justify, layer)
    local fs = parent:CreateFontString(nil, layer or "OVERLAY")
    local font = (STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF")
    fs:SetFont(font, size or 11, "")
    fs:SetTextColor(unpack(color or T.colors.text))
    fs:SetJustifyH(justify or "LEFT")
    fs:SetShadowOffset(1, -1)
    fs:SetShadowColor(0, 0, 0, 0.8)
    if fs.SetWordWrap then fs:SetWordWrap(false) end
    return fs
end

function T.Button(parent, label, w, h, onClick, tooltip)
    local b = CreateFrame("Button", nil, parent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    b:SetSize(w or 60, h or 18)
    if b.SetBackdrop then
        b:SetBackdrop({ bgFile = WHITE, edgeFile = WHITE, edgeSize = 1 })
        b:SetBackdropColor(0.10, 0.10, 0.11, 0.95)
        b:SetBackdropBorderColor(unpack(T.colors.borderD))
    end
    b.text = T.Text(b, 10, T.colors.gold, "CENTER")
    b.text:SetPoint("CENTER")
    b.text:SetText(label or "")
    b:SetScript("OnEnter", function(self)
        if self.SetBackdropBorderColor then self:SetBackdropBorderColor(unpack(T.colors.gold)) end
        if self.tooltip and GameTooltip then
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
            GameTooltip:Show()
        end
    end)
    b:SetScript("OnLeave", function(self)
        if self.SetBackdropBorderColor then self:SetBackdropBorderColor(unpack(T.colors.borderD)) end
        if GameTooltip then GameTooltip:Hide() end
    end)
    b.tooltip = tooltip
    if onClick then b:SetScript("OnClick", onClick) end
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    function b:SetLabel(t) self.text:SetText(t) end
    return b
end

function T.Bar(parent, h)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetHeight(h or 6)
    bar:SetStatusBarTexture(WHITE)
    bar:SetStatusBarColor(unpack(T.colors.bar))
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(unpack(T.colors.barBg))
    bar.bg = bg
    -- second (target) marker
    local mark = bar:CreateTexture(nil, "OVERLAY")
    mark:SetColorTexture(1, 1, 1, 0.5)
    mark:SetWidth(1)
    mark:SetPoint("TOP")
    mark:SetPoint("BOTTOM")
    mark:Hide()
    bar.mark = mark
    function bar:SetMarker(frac)
        if not frac or frac <= 0 or frac >= 1 then self.mark:Hide() return end
        self.mark:ClearAllPoints()
        self.mark:SetPoint("TOP", self, "TOPLEFT", self:GetWidth() * frac, 0)
        self.mark:SetPoint("BOTTOM", self, "BOTTOMLEFT", self:GetWidth() * frac, 0)
        self.mark:Show()
    end
    return bar
end

-- Checkbox: uses UICheckButtonTemplate when the client has it, otherwise a
-- self-drawn check button (templates differ between client families).
function T.CheckButton(parent, size)
    local ok, cb = pcall(CreateFrame, "CheckButton", nil, parent, "UICheckButtonTemplate")
    if not ok or not cb then
        cb = CreateFrame("CheckButton", nil, parent)
        cb:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
        cb:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
        cb:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
        cb:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
    end
    cb:SetSize(size or 22, size or 22)
    return cb
end

function T.Check(parent, label, getter, setter, tooltip)
    local cb = T.CheckButton(parent, 22)
    local fs = T.Text(cb, 11, T.colors.text)
    fs:SetPoint("LEFT", cb, "RIGHT", 4, 0)
    fs:SetText(label)
    if cb.Text then cb.Text:SetText("") end
    cb.label = fs
    cb:SetScript("OnClick", function(self) setter(self:GetChecked() and true or false) end)
    cb:SetScript("OnShow", function(self) self:SetChecked(getter() and true or false) end)
    if tooltip then
        cb:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tooltip, 1, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    cb.Refresh = function(self) self:SetChecked(getter() and true or false) end
    return cb
end

-- Simple mouse-wheel scroll area (avoids template differences between clients)
function T.Scroll(parent)
    local sf = CreateFrame("ScrollFrame", nil, parent)
    local content = CreateFrame("Frame", nil, sf)
    content:SetSize(10, 10)
    sf:SetScrollChild(content)
    sf:EnableMouseWheel(true)
    local thumb = sf:CreateTexture(nil, "OVERLAY")
    thumb:SetColorTexture(unpack(T.colors.border))
    thumb:SetWidth(2)
    sf.thumb = thumb
    function sf:UpdateThumb()
        local h, ch = self:GetHeight(), content:GetHeight()
        if ch <= h + 1 then self.thumb:Hide() return end
        local th = math.max(16, h * h / ch)
        local pos = (self:GetVerticalScroll() / (ch - h)) * (h - th)
        self.thumb:ClearAllPoints()
        self.thumb:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, -pos)
        self.thumb:SetHeight(th)
        self.thumb:Show()
    end
    sf:SetScript("OnMouseWheel", function(self, delta)
        local max = math.max(0, content:GetHeight() - self:GetHeight())
        local v = ns.Clamp(self:GetVerticalScroll() - delta * 40, 0, max)
        self:SetVerticalScroll(v)
        self:UpdateThumb()
    end)
    sf:SetScript("OnSizeChanged", function(self, w)
        content:SetWidth(w)
        self:UpdateThumb()
    end)
    sf.content = content
    return sf
end

function T.Divider(parent)
    local t = parent:CreateTexture(nil, "ARTWORK")
    t:SetColorTexture(unpack(T.colors.borderD))
    t:SetHeight(1)
    return t
end

function T.ConfidenceTag(conf)
    if conf == "client" then return "" end
    if conf == "forever-guide" then return ns.GREY .. " [Forever guide]|r" end
    if conf == "unknown" then return ns.ORANGE .. " [unknown]|r" end
    return ns.GREY .. " [Classic data, unverified]|r"
end
