-- Minimal WoW API mock for smoke-testing JA logic and UI construction
local frames = {}
local timers = {}
unpack = unpack or table.unpack
function wipe(t) for k in pairs(t) do t[k] = nil end return t end
-- a frame clock that moves on every call: os.clock() ticks too coarsely, so two
-- builds in a row could look like the same frame and reuse per-frame caches
local clock = 0
function GetTime() clock = clock + 0.001; return clock end
time = os.time
STANDARD_TEXT_FONT = "Fonts\\FRIZQT__.TTF"
BackdropTemplateMixin = {}
UISpecialFrames = {}
NUM_BAG_SLOTS = 4
WOW_PROJECT_ID = 99
function GetLocale() return "enUS" end
function GetBuildInfo() return "1.60.1", "99999", "Nov 2026", 16001 end
function UnitLevel() return 27 end
function UnitFactionGroup() return "Alliance" end
function GetRealZoneText() return "Wetlands" end
function GetCursorPosition() return 0, 0 end

local function newObj(kind)
  local o = { _scripts = {}, _shown = true, _w = 300, _h = 300, _events = {} }
  local mt = {}
  mt.__index = function(t, k)
    local f = rawget(mt, "m_" .. k)
    if f then return f end
    return function(self, ...) return nil end
  end
  mt.m_SetScript = function(self, n, fn) self._scripts[n] = fn end
  mt.m_HookScript = function(self, n, fn) self._scripts[n] = fn end
  mt.m_GetScript = function(self, n) return self._scripts[n] end
  mt.m_RegisterEvent = function(self, e) if e == "LEARNED_SPELL_IN_SKILL_LINE" then error("unknown event") end self._events[e] = true end
  mt.m_Show = function(self) self._shown = true; if self._scripts.OnShow then self._scripts.OnShow(self) end end
  mt.m_Hide = function(self) self._shown = false end
  mt.m_SetShown = function(self, v) if v then self:Show() else self:Hide() end end
  mt.m_IsShown = function(self) return self._shown end
  mt.m_GetWidth = function(self) return self._w end
  mt.m_GetHeight = function(self) return self._h end
  mt.m_SetWidth = function(self, w) self._w = w end
  mt.m_SetHeight = function(self, h) self._h = h end
  mt.m_SetSize = function(self, w, h) self._w, self._h = w, h end
  mt.m_GetPoint = function() return "CENTER", nil, "CENTER", 0, 0 end
  mt.m_GetVerticalScroll = function() return 0 end
  mt.m_GetChecked = function(self) return self._checked end
  mt.m_SetChecked = function(self, v) self._checked = v end
  mt.m_SetText = function(self, t) assert(t == nil or type(t) == "string" or type(t) == "number", "SetText non-string") self._text = t end
  mt.m_GetText = function(self) return self._text end
  mt.m_GetEffectiveScale = function() return 1 end
  mt.m_GetCenter = function() return 0, 0 end
  mt.m_CreateTexture = function() return newObj("Texture") end
  mt.m_CreateFontString = function() return newObj("FontString") end
  return setmetatable(o, mt)
end
function CreateFrame(kind, name, parent, template)
  local f = newObj(kind)
  if template and template:find("CheckButton") then f.Text = newObj("FontString") end
  frames[#frames + 1] = f
  if name then _G[name] = f end
  return f
end
UIParent = newObj("Frame"); Minimap = newObj("Frame"); GameTooltip = newObj("Frame")
DEFAULT_CHAT_FRAME = { AddMessage = function(_, m) print("[chat] " .. m:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end }
C_Timer = {
  After = function(d, fn) timers[#timers + 1] = fn end,
  NewTicker = function(d, fn) return { Cancel = function() end } end,
}
function RunTimers() local n = 0 while #timers > 0 and n < 50 do local t = table.remove(timers, 1); t(); n = n + 1 end end
function FireEvent(e, ...)
  for _, f in ipairs(frames) do if f._events[e] and f._scripts.OnEvent then f._scripts.OnEvent(f, e, ...) end end
end
SlashCmdList = {}
C_AddOns = { IsAddOnLoaded = function(n) return (n == "TomTom" and HAS_TOMTOM) or false end, GetAddOnMetadata = function() return "0.1.0" end,
  GetNumAddOns = function() return 2 end, GetAddOnInfo = function(i) return ({ "TomTom", "FollowTheArrow" })[i], "x" end }
Settings = { RegisterCanvasLayoutCategory = function() return { GetID = function() return 1 end } end, RegisterAddOnCategory = function() end }
Enum = { UIMapType = { Zone = 3, Continent = 2 }, CraftingReagentType = { Basic = 1 } }

-- Professions (First Aid deliberately missing from GetProfessions, like Retail)
local PROF = { [1] = { "Herbalism", "i", 178, 225, 0, 0, 182, 0 }, [2] = { "Alchemy", "i", 201, 225, 0, 0, 171, 0 },
  [4] = { "Fishing", "i", 160, 225, 0, 0, 356, 0 }, [5] = { "Cooking", "i", 150, 150, 0, 0, 185, 0 } }
function GetProfessions() return 1, 2, nil, 4, 5 end
function GetProfessionInfo(i) return unpack(PROF[i]) end
SetSkill = function(i, v) PROF[i][3] = v end

ITEMS = { [3820] = "Stranglekelp", [3821] = "Goldthorn", [3371] = "Leaded Vial", [2592] = "Wool Cloth", [3818] = "Fadeleaf",
  [6303] = "Raw Mithril Head Trout" }
COUNTS = { [3821] = 3, [2592] = 40 }
C_Item = { GetItemNameByID = function(id) return ITEMS[id] end, GetItemCount = function(id) return COUNTS[id] or 0 end }
C_Container = { GetContainerNumSlots = function(b) return b == 0 and 2 or 0 end,
  GetContainerItemInfo = function(b, s) if s == 1 then return { itemID = 3821, stackCount = COUNTS[3821] or 0, itemName = "Goldthorn" } end
    if s == 2 then return { itemID = 2592, stackCount = 40 } end end }

CURRENT_TRADE = nil
local RECIPES = {
  ALCHEMY = { info = { professionID = 171, professionName = "Alchemy", skillLevel = 201, maxSkillLevel = 225 },
    list = { [101] = { name = "Elixir of Agility", learned = true, relativeDifficulty = 0, reag = { { 3820, 1 }, { 3821, 1 }, { 3371, 1 } } },
             [102] = { name = "Lesser Mana Potion", learned = true, relativeDifficulty = 3, reag = { { 3820, 1 } } },
             [103] = { name = "Elixir of Fortitude", learned = false, relativeDifficulty = 0, reag = { { 3821, 2 } } } } },
  FIRSTAID = { info = { professionID = 129, professionName = "First Aid", skillLevel = 147, maxSkillLevel = 150 },
    list = { [201] = { name = "Heavy Wool Bandage", learned = true, relativeDifficulty = 1, reag = { { 2592, 2 } } } } },
  COOKING = { info = { professionID = 185, professionName = "Cooking", skillLevel = 150, maxSkillLevel = 150 },
    list = { [301] = { name = "Rockscale Cod", learned = true, relativeDifficulty = 0, reag = { { 6303, 1 } } } } },
}
C_TradeSkillUI = {
  GetProfessionInfoBySkillLineID = function(id) if id == 129 then return { skillLevel = 147, maxSkillLevel = 150, professionName = "First Aid" } end
    return { skillLevel = 0, maxSkillLevel = 0 } end,
  GetBaseProfessionInfo = function() return CURRENT_TRADE and RECIPES[CURRENT_TRADE].info end,
  GetAllRecipeIDs = function() local o = {} for id in pairs(RECIPES[CURRENT_TRADE].list) do o[#o + 1] = id end return o end,
  GetRecipeInfo = function(id) local r = RECIPES[CURRENT_TRADE].list[id]; return { name = r.name, learned = r.learned, relativeDifficulty = r.relativeDifficulty } end,
  GetRecipeSchematic = function(id) local r = RECIPES[CURRENT_TRADE].list[id]; local s = {}
    for _, g in ipairs(r.reag) do s[#s + 1] = { reagentType = 1, quantityRequired = g[2], reagents = { { itemID = g[1] } } } end
    return { reagentSlotSchematics = s } end,
  GetRecipeSourceText = function() return "|cffffd100Trainer:|r Someone" end,
}
local MAPS = { [1415] = { name = "Eastern Kingdoms", mapType = 2 }, [1437] = { name = "Wetlands", mapType = 3, parentMapID = 1415 },
  [1417] = { name = "Arathi Highlands", mapType = 3, parentMapID = 1415 }, [1453] = { name = "Stormwind City", mapType = 3, parentMapID = 1415 },
  [1434] = { name = "Stranglethorn Vale", mapType = 3, parentMapID = 1415 }, [1414] = { name = "Kalimdor", mapType = 2 }, [1440] = { name = "Ashenvale", mapType = 3, parentMapID = 1414 }, [1424] = { name = "Hillsbrad Foothills", mapType = 3, parentMapID = 1415 } }
PIN = nil
C_Map = { GetMapInfo = function(id) return MAPS[id] end, GetBestMapForUnit = function() return 1437 end,
  GetPlayerMapPosition = function() return { x = 0.5, y = 0.5 } end,
  GetMapWorldSize = function() return 4000, 2700 end,
  HasUserWaypoint = function() return PIN ~= nil end,
  GetUserWaypoint = function() return PIN and { uiMapID = PIN.m, position = { x = PIN.x, y = PIN.y } } end,
  SetUserWaypoint = function(p) PIN = p end, ClearUserWaypoint = function() PIN = nil end,
  CanSetUserWaypointOnMap = function() return true end }
UiMapPoint = { CreateFromCoordinates = function(m, x, y) return { m = m, x = x, y = y } end }
C_SuperTrack = { SetSuperTrackedUserWaypoint = function() end, IsSuperTrackingAnything = function() return false end }
TOMTOM_LOG = {}
TomTom = { AddWaypoint = function(self, m, x, y, o) local uid = { m, x, y, o.title }; TOMTOM_LOG[#TOMTOM_LOG + 1] = "add crazy=" .. tostring(o.crazy); return uid end,
  RemoveWaypoint = function(self, uid) TOMTOM_LOG[#TOMTOM_LOG + 1] = "remove" end }
function UnitClass() return "Warrior", "WARRIOR" end
function UnitRace() return "Human", "Human", 1 end
KNOWN = { [71] = true }
function IsPlayerSpell(id) return KNOWN[id] or false end
DONEQ = {}
C_QuestLog = {
  IsQuestFlaggedCompleted = function(id) return DONEQ[id] or false end,
  GetNumQuestLogEntries = function() return 1 end,
  GetInfo = function(i) return { title = "Yorus Barleybrew", questID = 1698 } end,
  GetTitleForQuestID = function(id) return id == 1698 and "Yorus Barleybrew" or nil end,
}
C_Map.GetAreaInfo = function(id) return ({ [1519] = "Stormwind City", [1537] = "Ironforge", [11] = "Wetlands", [12] = "Elwynn Forest", [1657] = "Darnassus" })[id] end
