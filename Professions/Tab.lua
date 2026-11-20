-- Journal Assistant - Professions tab of the dashboard
-- One row per detected profession: skill / target bar, On/Off switch under the
-- icon, next objective; click to show rank, recipes, target and priority.

local _, ns = ...
local T = ns.Theme
local C = T.colors
local UI = ns.UI
local PROF_H, PROF_H_OPEN = 46, 84

local function CreateProfRow()
    local r = CreateFrame("Button", nil, UI.content, BackdropTemplateMixin and "BackdropTemplate" or nil)
    if r.SetBackdrop then
        r:SetBackdrop({ bgFile = T.WHITE })
        r:SetBackdropColor(unpack(C.row))
    end
    r.icon = r:CreateTexture(nil, "ARTWORK")
    r.icon:SetSize(22, 22)
    r.icon:SetPoint("TOPLEFT", 4, -4)
    r.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    r.name = T.Text(r, 12, C.text)
    r.name:SetPoint("TOPLEFT", 32, -4)
    -- on / off switch, under the profession icon
    r.toggle = T.Button(r, "On", 26, 13)
    r.toggle:SetPoint("TOP", r.icon, "BOTTOM", 0, -2)
    r.toggle.tooltip = "Switch this profession on or off. Off = paused: it gets no tasks at all."
    r.toggle:SetScript("OnClick", function() ns:TogglePaused(r.key) end)
    r.value = T.Text(r, 11, C.gold, "RIGHT")
    r.value:SetPoint("TOPRIGHT", -6, -4)
    r.bar = T.Bar(r, 5)
    r.bar:SetPoint("TOPLEFT", 32, -20)
    r.bar:SetPoint("RIGHT", -6, 0)
    r.obj = T.Text(r, 10, C.dim)
    r.obj:SetPoint("TOPLEFT", 32, -29)
    r.obj:SetPoint("RIGHT", -6, 0)
    -- expanded details
    r.rank = T.Text(r, 10, C.text)
    r.rank:SetPoint("TOPLEFT", 32, -44)
    r.rank:SetPoint("RIGHT", -6, 0)
    r.recipes = T.Text(r, 10, C.dim)
    r.recipes:SetPoint("TOPLEFT", 32, -57)
    r.recipes:SetPoint("RIGHT", -6, 0)
    r.minus = T.Button(r, "-", 18, 14)
    r.minus:SetPoint("TOPLEFT", 32, -68)
    r.target = T.Text(r, 10, C.gold, "CENTER")
    r.target:SetPoint("LEFT", r.minus, "RIGHT", 2, 0)
    r.target:SetWidth(70)
    r.plus = T.Button(r, "+", 18, 14)
    r.plus:SetPoint("LEFT", r.target, "RIGHT", 2, 0)
    r.prio = T.Button(r, "Priority", 90, 14)
    r.prio:SetPoint("LEFT", r.plus, "RIGHT", 10, 0)
    r:SetScript("OnClick", function(self)
        ns.char.collapsed["prof:" .. self.key] = not ns.char.collapsed["prof:" .. self.key]
        UI:Refresh()
    end)
    r.minus:SetScript("OnClick", function() ns:StepTarget(r.key, -1) end)
    r.plus:SetScript("OnClick", function() ns:StepTarget(r.key, 1) end)
    r.prio:SetScript("OnClick", function() ns:CyclePriority(r.key) end)
    r.prio.tooltip = "Planner weight for this profession (Normal / High / Low)"
    r:SetScript("OnEnter", function(self)
        local o = ns.Planner.objectives[self.key]
        if o and o.task then UI.TaskTooltip(self, o.task) end
    end)
    r:SetScript("OnLeave", function() GameTooltip:Hide() end)
    return r
end

local pool = UI:Pool("professions", CreateProfRow)

local function Render(L)
    local label, place = L.label, L.place
    if #ns.Professions.list == 0 then label("No professions detected. Try /ja refresh or /ja debug.") end
    for _, p in ipairs(ns.Professions.list) do
        local r = pool:Next()
        r.key = p.key
        local target = ns:GetTarget(p.key)
        local open = not ns.char.collapsed["prof:" .. p.key]
        r.icon:SetTexture(p.icon)
        local paused = ns.Professions:IsPaused(p.key)
        r.name:SetText(p.name .. (paused and (ns.GREY .. "  (paused)|r") or ""))
        r.name:SetTextColor(unpack(paused and C.dim or C.text))
        r.icon:SetDesaturated(paused)
        r.toggle:SetLabel(paused and "Off" or "On")
        r.toggle.text:SetTextColor(unpack(paused and C.dim or C.green))
        local remain = math.max(0, target - p.skill)
        r.value:SetText(("%d / %d"):format(p.skill, target) .. (remain > 0 and (ns.GREY .. "  (" .. remain .. " to go)|r") or (ns.GREEN .. "  done|r")))
        r.bar:SetValue(target > 0 and math.min(1, p.skill / target) or 0)
        r.bar:SetMarker(target > 0 and p.maxSkill < target and (p.maxSkill / target) or nil)
        local o = ns.Planner.objectives[p.key]
        local otext = o and o.text or ""
        if o and o.state == "blocked" then otext = ns.RED .. otext .. "|r" end
        r.obj:SetText("Next: " .. otext)
        local rk = ns.Data.RankName(p.maxSkill)
        local nr = ns.Data.NextRank(p.key, p.maxSkill)
        local rankLine = ("Rank: %s (cap %d)"):format(rk, p.maxSkill)
        if nr and p.maxSkill < target then
            rankLine = rankLine .. ("  ·  Next: %s %d via %s, needs skill %d%s"):format(nr.rank, nr.cap, nr.method,
                nr.reqSkill or 0, (nr.minLevel or 1) > 1 and (", level " .. nr.minLevel) or "")
        end
        r.rank:SetText(rankLine)
        local learned, unlearned, cache = ns.Recipes:Summary(p.key)
        if cache then
            r.recipes:SetText(("Recipes: %d learned, %d not learned (scanned at %s)"):format(learned, unlearned, tostring(cache.scannedSkill)))
        elseif p.kind == "craft" then
            r.recipes:SetText(ns.ORANGE .. "Recipes not scanned - open the " .. p.name .. " window once.|r")
        else
            r.recipes:SetText("Source: " .. tostring(p.source))
        end
        r.target:SetText("Target " .. target)
        r.prio:SetLabel("Priority: " .. ns:GetPriority(p.key))
        for _, f in ipairs({ r.rank, r.recipes, r.minus, r.target, r.plus, r.prio }) do f:SetShown(open) end
        place(r, open and PROF_H_OPEN or PROF_H)
    end
    label(ns.GREY .. "Click a profession to show its rank, recipes, target and priority.|r")
end

UI:AddTab({ key = "PROF", label = "Professions", order = 20, render = Render,
    count = function() return #ns.Professions.list end })

UI.emptyHint = function()
    if #ns.Professions.list == 0 then
        return "No professions detected yet", "Type /ja refresh, or /ja debug if this persists."
    end
end
ns:AddCommand("professions", function() UI:Show(); UI:SelectTab("PROF") end)
