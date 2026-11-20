-- Journal Assistant - Class quests
--
-- Class-specific source: your class's chains from Data/Classes/<Class>.lua,
-- turned into tasks by the generic chain code (ChainTasks.lua).

local _, ns = ...
local GP = ns.GuidePlan
local QC = ns.QuestChains

local CL = {}
ns.ClassQuests = CL

for _, list in pairs(ns.Data.classQuests or {}) do QC:RegisterChains(list) end

function CL:PlayerClass()
    local _, token = UnitClass("player")
    return token
end

-- chains of your class that fit your faction / race
function CL:Chains()
    return QC:ChainsFrom((ns.Data.classQuests or {})[self:PlayerClass() or ""])
end

function GP:AddClassQuests(ctx)
    if not ns.db.showClassQuests then return end
    self:AddChainGroup(ctx, CL:Chains(), "CLASS", "", "CLASS")
end

-- diagnostics: /ja debug
ns.Diagnostics:AddSection("Class quests", function(add)
    local _, raceToken = UnitRace("player")
    add(("  Class: %s  Race token: %s  Enabled: %s"):format(tostring(CL:PlayerClass()), tostring(raceToken), tostring(ns.db.showClassQuests)))
    for _, c in ipairs(CL:Chains()) do
        local st = QC:State(c)
        add(("  L%-2d %-45s %d/%d%s%s"):format(c.level, c.title, st.nDone, st.total, st.complete and " complete" or "",
            st.inLog and " (in log)" or ""))
    end
end)
