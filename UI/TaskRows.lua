-- Journal Assistant - Task rows and the task tooltip (generic)
-- Used by every tab that lists tasks and by the tracker.

local _, ns = ...
local T = ns.Theme
local C = T.colors
local UI = ns.UI
local TASK_H = 46
UI.TASK_H = TASK_H

-- "~1g 20s" for what is still missing (Auctionator data), or a hint when unpriced
function UI.CostText(t)
    if t.cost then
        return ns.GOLD .. "~" .. ns.Prices:Format(t.cost) .. "|r" .. ((t.costMissing and #t.costMissing > 0) and "+" or "")
    elseif t.costMissing and #t.costMissing > 0 then
        return ns.GREY .. (ns.Prices:Available() and "no AH price yet" or "no price data") .. "|r"
    end
end

---------------------------------------------------------------------------
-- Tooltip shared with the tracker
---------------------------------------------------------------------------
function UI.TaskTooltip(owner, t, anchor)
    if not t or not GameTooltip then return end
    GameTooltip:SetOwner(owner, anchor or "ANCHOR_RIGHT")
    GameTooltip:AddLine(t.title, C.gold[1], C.gold[2], C.gold[3], true)
    if t.detail and t.detail ~= "" then GameTooltip:AddLine(t.detail, 0.85, 0.85, 0.85, true) end
    if t.zone then GameTooltip:AddLine("Destination: " .. t.zone .. (t.npc and (" - " .. t.npc) or ""), 0.7, 0.7, 0.7, true) end
    if t.materials and #t.materials > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Materials", C.gold[1], C.gold[2], C.gold[3])
        for _, m in ipairs(t.materials) do
            local have = m.have or ns.Inventory:Count(m)
            local ok = have >= m.need
            GameTooltip:AddDoubleLine(m.name or "?", ("%d / %d"):format(have, m.need),
                0.85, 0.85, 0.85, ok and 0.45 or 0.9, ok and 0.8 or 0.5, ok and 0.45 or 0.3)
        end
    end
    if (t.costLines and #t.costLines > 0) or (t.costMissing and #t.costMissing > 0) then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Estimated cost" .. (t.cost and (": " .. ns.Prices:Format(t.cost)) or ""), C.gold[1], C.gold[2], C.gold[3])
        for _, l in ipairs(t.costLines or {}) do GameTooltip:AddLine(l, 0.85, 0.85, 0.85, true) end
        if t.costMissing and #t.costMissing > 0 then
            GameTooltip:AddLine((ns.Prices:Available() and "No Auctionator price yet for: " or "No price data (Auctionator not loaded) for: ")
                .. table.concat(t.costMissing, ", "), 0.55, 0.55, 0.55, true)
        end
        if t.kind == "gather" or t.kind == "fish" then
            GameTooltip:AddLine("(what the materials would cost to buy instead of gathering)", 0.5, 0.5, 0.5, true)
        end
    end
    if t.forSteps then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Supplies crafting step: " .. table.concat(t.forSteps, ", "), 0.6, 0.75, 0.9, true)
    end
    if t.reasons and #t.reasons > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Why: " .. table.concat(t.reasons, ", "), 0.6, 0.75, 0.6, true)
    end
    if t.blocked then GameTooltip:AddLine("Blocked: " .. t.blocked, 0.9, 0.35, 0.35, true) end
    if t.caution then GameTooltip:AddLine("Caution: " .. t.caution, 0.9, 0.6, 0.25, true) end
    if t.confidence and t.confidence ~= "client" then
        GameTooltip:AddLine("Data: " .. (t.confidence == "forever-guide" and "WoW: Forever guide + Classic details"
            or t.confidence == "unknown" and "unknown for Forever" or "Classic data, not verified on Forever"), 0.55, 0.55, 0.55, true)
    end
    GameTooltip:AddLine(" ")
    -- module-specific click behaviour / note (e.g. focusing a crafting step)
    if t.clickHint then GameTooltip:AddLine(t.clickHint, 0.6, 0.75, 0.9, true) end
    GameTooltip:AddLine("Click: make active   ·   /ja mark: save your position as its destination", 0.45, 0.45, 0.45, true)
    GameTooltip:Show()
end

local function CreateTaskRow()
    local r
    r = CreateFrame("Button", nil, UI.content, BackdropTemplateMixin and "BackdropTemplate" or nil)
    if r.SetBackdrop then
        r:SetBackdrop({ bgFile = T.WHITE, edgeFile = T.WHITE, edgeSize = 1 })
        r:SetBackdropColor(unpack(C.row))
        r:SetBackdropBorderColor(0, 0, 0, 0)
    end
    r:SetHeight(TASK_H)
    r.check = T.CheckButton(r, 20)
    r.check:SetPoint("TOPLEFT", 2, -3)
    r.check:SetScript("OnClick", function(self)
        if r.task then ns.Planner:SetDone(r.task.id, self:GetChecked() and true or false) end
    end)
    -- guide tabs (class quests, books, camping): On/Off switch, like professions
    r.onoff = T.Button(r, "Off", 24, 14)
    r.onoff:SetPoint("TOPLEFT", 1, -5)
    r.onoff.tooltip = "On: this quest's steps go into the Plan tab (and the arrow can guide you). Off: not planned.\nRight-click the row to mark it done by hand."
    r.onoff:SetScript("OnClick", function()
        if r.task then ns.Planner:SetTracked(r.task.id, not r.task.tracked) end
    end)
    r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    r.title = T.Text(r, 11, C.text)
    r.title:SetPoint("TOPLEFT", 26, -5)
    r.title:SetPoint("RIGHT", -86, 0)
    r.sub = T.Text(r, 10, C.dim)
    r.sub:SetPoint("TOPLEFT", 26, -19)
    r.sub:SetPoint("RIGHT", -6, 0)
    r.mats = T.Text(r, 10, C.dim)
    r.mats:SetPoint("TOPLEFT", 26, -31)
    r.mats:SetPoint("RIGHT", -6, 0)
    r.skip = T.Button(r, "Skip", 38, 16)
    r.skip:SetPoint("TOPRIGHT", -4, -4)
    r.go = T.Button(r, "Go", 38, 16)
    r.go:SetPoint("RIGHT", r.skip, "LEFT", -4, 0)
    r.go.tooltip = "Navigate to this task"
    r.bar = T.Bar(r, 2)
    r.bar:SetPoint("BOTTOMLEFT", 26, 2)
    r.bar:SetPoint("BOTTOMRIGHT", -6, 2)
    r.go:SetScript("OnClick", function()
        if r.task then ns.Planner:Select(r.task.id); ns.Navigation:Navigate(r.task, true) end
    end)
    r.skip:SetScript("OnClick", function()
        if r.task then ns.Planner:Skip(r.task.id, r.task.skipped) end
    end)
    r:SetScript("OnClick", function(_, button)
        if button == "RightButton" then
            if r.task and r.groupMode then ns.Planner:SetDone(r.task.id, not r.task.done) end
            return
        end
        if r.task and r.groupMode then
            -- guide tab: clicking selects the first step once the chain is in the plan
            if r.task.tracked then ns.Planner:SetTracked(r.task.id, true) end
            return
        end
        if r.task and r.task.onClick then
            r.task.onClick(r.task) -- the task's own action (e.g. switch the focused crafting step)
        elseif r.task and not r.task.done and not r.task.skipped and not r.task.blocked then
            ns.Planner:Select(r.task.id)
        end
    end)
    r:SetScript("OnEnter", function(self) UI.TaskTooltip(self, self.task) end)
    r:SetScript("OnLeave", function() GameTooltip:Hide() end)
    return r
end

---------------------------------------------------------------------------
-- Refresh / layout
---------------------------------------------------------------------------
local function MaterialsLine(t)
    if not t.materials or #t.materials == 0 then return "" end
    local parts = {}
    for i, m in ipairs(t.materials) do
        if i > 3 then parts[#parts + 1] = "..."; break end
        local have = m.have or ns.Inventory:Count(m)
        local col = have >= m.need and ns.GREEN or ns.ORANGE
        parts[#parts + 1] = ("%s%d/%d|r %s"):format(col, math.min(have, m.need), m.need, m.name or "?")
    end
    return table.concat(parts, ", ")
end

local function ProfName(key)
    return key and ns:CategoryName(key) or "Materials"
end
UI.CategoryLabel = ProfName

local function PassesFilter(t)
    local f = ns.char.filter
    if not f or f == "ALL" then return true end
    if t.prof == f then return true end
    if t.materials then
        for _, m in ipairs(t.materials) do
            if m.demand then
                for _, c in ipairs(m.demand.crafts) do
                    if c:find(":" .. f .. ":", 1, true) then return true end
                end
            end
        end
    end
    return false
end

local function FillTaskRow(r, t, state, groupMode)
    r.task = t
    r.groupMode = groupMode and true or nil
    local active = ns.Planner.active and ns.Planner.active.id == t.id
    if groupMode then
        r.check:Hide()
        r.onoff:SetShown(state ~= "done")
        r.onoff:SetLabel(t.tracked and "On" or "Off")
        r.onoff.text:SetTextColor(unpack(t.tracked and C.green or C.dim))
    else
        r.onoff:Hide()
        r.check:SetChecked(t.done)
        r.check:SetShown(state ~= "blocked")
    end
    local col = (state == "blocked" or state == "skipped" or state == "done") and C.dim or (active and C.gold or C.text)
    r.title:SetTextColor(unpack(col))
    r.title:SetText((t.order and state == "active" and (t.order .. ". ") or "") .. t.title)
    local sub = {}
    sub[#sub + 1] = ProfName(t.prof)
    sub[#sub + 1] = t.zone or "Anywhere"
    if t.qty then sub[#sub + 1] = "~" .. t.qty .. (t.kind == "fish" and " catches" or " nodes") end
    if t.progressText and t.progressText ~= "" then sub[#sub + 1] = t.progressText end
    local costText = UI.CostText(t)
    if costText then sub[#sub + 1] = costText end
    if t.forSteps then sub[#sub + 1] = ns.GREY .. "for: " .. table.concat(t.forSteps, ", ") .. "|r" end
    local s = table.concat(sub, "  ·  ")
    if state == "blocked" then s = ns.RED .. t.blocked .. "|r  ·  " .. s end
    if t.caution and state == "active" then s = ns.ORANGE .. "!|r " .. s end
    r.sub:SetText(s .. T.ConfidenceTag(t.confidence))
    r.mats:SetText(MaterialsLine(t))
    r.bar:SetValue(t.progress or 0)
    r.skip:SetLabel(t.skipped and "Undo" or "Skip")
    r.skip:SetShown(state ~= "done" and not groupMode)
    r.go:SetShown(state == "active" and t.zone ~= nil)
    if r.SetBackdropColor then
        r:SetBackdropColor(unpack(active and C.rowHi or C.row))
        r:SetBackdropBorderColor(unpack(active and C.border or { 0, 0, 0, 0 }))
    end
end

UI.FillTaskRow = FillTaskRow
UI.PassesFilter = PassesFilter
UI.taskPool = UI:Pool("tasks", CreateTaskRow)
