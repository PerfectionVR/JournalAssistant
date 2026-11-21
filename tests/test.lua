local root = ...
dofile(TOOLS .. "/mock.lua")
local ns = {}
-- load every .lua file in TOC order (as the game does)
local files = {}
for line in io.lines(root .. "/JournalAssistant.toc") do
  line = line:gsub("%c", "")
  if line:match("%.lua$") and not line:match("^#") then files[#files + 1] = (line:gsub("\\", "/")) end
end
for _, f in ipairs(files) do assert(loadfile(root .. "/" .. f))("JournalAssistant", ns) end
FireEvent("ADDON_LOADED", "JournalAssistant")
FireEvent("PLAYER_LOGIN")
RunTimers()
local function dump(title)
  print("\n==== " .. title .. " ====")
  for _, p in ipairs(ns.Professions.list) do
    local o = ns.Planner.objectives[p.key]
    print(("  %-10s %d/%d src=%s  next: %s"):format(p.name, p.skill, p.maxSkill, p.source, o and o.text or "-"))
  end
  print("  route: " .. table.concat(ns.Planner.route, " > "))
  for i, t in ipairs(ns.Planner.ordered) do print(("  %d. [%s] %s | zone=%s | %s"):format(i, t.kind, t.title, tostring(t.zone), t.progressText or "")) end
  for _, t in ipairs(ns.Planner.blocked) do print("  BLOCKED: " .. t.title .. " -- " .. t.blocked) end
  print("  active: " .. (ns.Planner.active and ns.Planner.active.title or "none"))
end
dump("after login (no recipe scans)")
for _, prof in ipairs({ "ALCHEMY", "FIRSTAID", "COOKING" }) do
  CURRENT_TRADE = prof; FireEvent("TRADE_SKILL_SHOW"); RunTimers()
end
dump("after scanning Alchemy/First Aid/Cooking windows")
for _, t in ipairs(ns.Planner.ordered) do if t.kind == "gather" then print("  gather detail:\n" .. t.detail) end end
for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
  for _, t in ipairs(list) do
    if t.id:find("^learn:") or t.gate then print("  >> " .. t.title .. " | zone=" .. tostring(t.zone) .. (t.blocked and (" | BLOCKED " .. t.blocked) or "") .. "\n     " .. t.detail:gsub("\n", "\n     ")) end
  end
end
ns.UI:Toggle(); ns.UI:Refresh()
SlashCmdList.JOURNALASSIST("route")
SlashCmdList.JOURNALASSIST("nav")
print("pin after auto-nav:", PIN and (PIN.m .. " " .. PIN.x .. "," .. PIN.y) or "none")
for _, t in ipairs(ns.Planner.ordered) do if t.id:find("rank:FIRSTAID") then ns.Planner:Select(t.id) end end
RunTimers()
print("active now:", ns.Planner.active.title, "pin:", PIN and (PIN.m .. " " .. PIN.x .. "," .. PIN.y) or "none")
print("guidance:", ns.Navigation:GuidanceText())
PIN = { m = 1453, x = 0.1, y = 0.1 }
ns.Navigation.owned.key = nil
ns.Navigation:Navigate(ns.Planner.active, false)
print("foreign pin preserved:", PIN.m == 1453)
HAS_TOMTOM = true; ns.Navigation:ClearOwned(); ns.Navigation:Navigate(ns.Planner.active, true); ns.Navigation:Navigate(ns.Planner.active, false)
ns.Navigation:SetAuto(false)
print("tomtom log:", table.concat(TOMTOM_LOG, " | "), "foreign pin still:", PIN and PIN.m)
COUNTS[3820] = 10; COUNTS[3371] = 10
ns.Inventory:MarkDirty()
C_TradeSkillUI.GetProfessionInfoBySkillLineID = function(id) if id == 129 then return { skillLevel = 150, maxSkillLevel = 225, professionName = "First Aid" } end return {} end
ns.char.profCache.FIRSTAID = nil
SetSkill(1, 185)
FireEvent("CHAT_MSG_SKILL"); RunTimers()
dump("after Herbalism 185, First Aid Expert learned, mats bought")
SlashCmdList.JOURNALASSIST("next"); RunTimers()
SlashCmdList.JOURNALASSIST("mark"); RunTimers()
SlashCmdList.JOURNALASSIST("target alchemy 300"); RunTimers()
dump("alchemy target 300")
local rep = ns.Diagnostics:Report()
print("\n" .. rep)
ns.Diagnostics:Show()
ns.Settings:Toggle()
SlashCmdList.JOURNALASSIST("compact"); SlashCmdList.JOURNALASSIST("help")
-- Arrow quick toggle with TomTom: zone-only gather task while in Wetlands
print("\n==== arrow mode ====")
TOMTOM_LOG = {}
for _, t in ipairs(ns.Planner.ordered) do if t.kind == "gather" then ns.Planner:Select(t.id) end end
RunTimers()
print("active:", ns.Planner.active.title)
SlashCmdList.JOURNALASSIST("arrow"); RunTimers()
print("guidance:", ns.Navigation:GuidanceText())
FireEvent("ZONE_CHANGED_NEW_AREA"); RunTimers() -- same zone: must not duplicate
print("after refresh (no dup expected):", table.concat(TOMTOM_LOG, " | "))
C_Map.GetBestMapForUnit = function() return 1417 end -- arrive in Arathi
FireEvent("ZONE_CHANGED_NEW_AREA"); RunTimers()
print("after arriving:", table.concat(TOMTOM_LOG, " | "), "guidance:", ns.Navigation:GuidanceText())
JournalAssistantAPI.ToggleArrow(); RunTimers()
print("arrowMode:", ns.db.arrowMode, "autoNav:", ns.db.autoNav)
HAS_TOMTOM = false; C_Map.GetBestMapForUnit = function() return 1437 end; PIN = nil
SlashCmdList.JOURNALASSIST("arrow"); RunTimers()
print("no tomtom -> pin:", PIN and (PIN.m .. " " .. PIN.x .. "," .. PIN.y) or "none")
SlashCmdList.JOURNALASSIST("arrow"); RunTimers()
print("pin after off:", PIN and "still set" or "cleared")
print("\n==== mining + skinning ====")
GetProfessions = function() return 1, 2, 3, 4, 5, 6 end
local base = GetProfessionInfo
GetProfessionInfo = function(i)
  if i == 3 then return "Mining", "i", 130, 150, 0, 0, 186, 0 end
  if i == 6 then return "Skinning", "i", 140, 150, 0, 0, 393, 0 end
  return base(i)
end
ns.char.selectedTask = nil
ns:Refresh(); RunTimers()
for _, t in ipairs(ns.Planner.ordered) do
  if t.prof == "MINING" or t.prof == "SKINNING" then print("  " .. t.title .. " | " .. tostring(t.zone) .. "\n    " .. t.detail:gsub("\n", "\n    ")) end
end
for _, t in ipairs(ns.Planner.blocked) do print("  BLOCKED: " .. t.title .. " -- " .. t.blocked) end
print("\nSMOKE TEST OK")
print("\n==== level 28 in Arathi, Herbalism 201 ====")
UnitLevel = function() return 28 end
C_Map.GetBestMapForUnit = function() return 1417 end
GetProfessions = function() return 1, 2, nil, 4, 5 end
SetSkill(1, 201)
ns.char.selectedTask = nil
ns:Refresh(); RunTimers()
for i, t in ipairs(ns.Planner.ordered) do print(("  %d. %s | %s"):format(i, t.title, tostring(t.zone))) end
for _, t in ipairs(ns.Planner.blocked) do print("  BLOCKED: " .. t.title .. " -- " .. t.blocked) if t.gate then print("     " .. t.detail:gsub("\n", "\n     ")) end end
print("  objective: " .. ns.Planner.objectives.HERBALISM.text)
print("END2")
print("\n==== class quests (warrior, human) ====")
local function showClass(lbl)
  print("-- " .. lbl)
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
    for _, t in ipairs(list) do if t.prof == "CLASS" then print("  " .. t.title .. " | " .. tostring(t.zone) .. (t.blocked and (" | BLOCKED " .. t.blocked) or "") .. " | " .. (t.progressText or "")) end end
  end
end
UnitLevel = function() return 28 end
ns:Refresh(); RunTimers(); showClass("level 28, Yorus in log")
for _, t in ipairs(ns.Planner.ordered) do if t.id == "class:war20" then print(t.detail) end end
DONEQ[1698] = true; DONEQ[1699] = true; DONEQ[1702] = true
SlashCmdList.JOURNALASSIST("refresh"); RunTimers(); showClass("level 28, shield chain done")
UnitLevel = function() return 30 end; C_Map.GetBestMapForUnit = function() return 1437 end
ns:Refresh(); RunTimers(); showClass("level 30")
KNOWN[2458] = true; ns:Refresh(); RunTimers(); showClass("level 30, berserker stance learned")
print(ns.Diagnostics:Report():match("%-%- Class quests %-%-.-\n\n"))
print("END3")
print("\n==== all classes at level 20 ====")
UnitLevel = function() return 20 end
local combos = { {"MAGE","Human","Alliance"}, {"MAGE","Scourge","Horde"}, {"HUNTER","Dwarf","Alliance"}, {"HUNTER","Skyborne","Horde"},
  {"ROGUE","Human","Alliance"}, {"ROGUE","Orc","Horde"}, {"WARLOCK","Gnome","Alliance"}, {"PALADIN","Human","Alliance"},
  {"PALADIN","Scourge","Horde"}, {"DRUID","NightElf","Alliance"}, {"DRUID","Skyborne","Horde"}, {"SHAMAN","Dwarf","Alliance"},
  {"SHAMAN","Tauren","Horde"}, {"PRIEST","Human","Alliance"} }
for _, c in ipairs(combos) do
  UnitClass = function() return c[1], c[1] end
  UnitRace = function() return c[2], c[2] end
  UnitFactionGroup = function() return c[3] end
  ns:Refresh(); RunTimers()
  local names = {}
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
    for _, t in ipairs(list) do if t.prof == "CLASS" then names[#names + 1] = t.title:gsub("Class quest: ", "") .. (t.blocked and " [later]" or "") end end
  end
  print(("%-8s %-9s %-8s %d: %s"):format(c[1], c[2], c[3], #names, table.concat(names, "; ")))
end
print("END4")
print("\n==== guide groups (human warrior 28, Wetlands) ====")
UnitClass = function() return "Warrior", "WARRIOR" end
UnitRace = function() return "Human", "Human" end
UnitFactionGroup = function() return "Alliance" end
UnitLevel = function() return 28 end
C_Map.GetBestMapForUnit = function() return 1437 end
COUNTS[209848] = 1
ns.Inventory:MarkDirty()
ns:Refresh(); RunTimers()
for _, key in ipairs({ "CLASS", "BOOKS", "CAMPING" }) do
  local g = ns.Planner.groups[key] or { active = {}, blocked = {} }
  print(("-- %s: %d now, %d later"):format(key, #g.active, #g.blocked))
  for i, t in ipairs(g.active) do if i <= 8 then print("   now:   " .. t.title .. " | " .. tostring(t.zone)) end end
  for i, t in ipairs(g.blocked) do if i <= 4 then print("   later: " .. t.title .. " -- " .. t.blocked) end end
end
local bs = ns.Planner.bookSummary; print(("books: %d/%d turned in, %d in bags"):format(bs.turned, bs.total, bs.inBags))
for _, t in ipairs(ns.Planner.groups.CAMPING.active) do if t.id:find("^camping:") then print(t.detail) end end
-- simulate turning in the book
ns.Books:OnTurnedIn(99999); COUNTS[209848] = 0; ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers()
bs = ns.Planner.bookSummary; print(("after turn-in: %d/%d turned in, %d in bags"):format(bs.turned, bs.total, bs.inBags))
ns.UI:Show(); ns.UI:Refresh()
print("plan has grouped tasks?", (function() for _, t in ipairs(ns.Planner.ordered) do if t.group then return "YES (bug)" end end return "no" end)())
print("END5")
print("\n==== greater mana potion source ====")
ns.char.recipes.ALCHEMY.list[11448] = { name = "Greater Mana Potion", learned = false, reagents = {}, source = "Trainer" }
SetSkill(2, 206)
C_Map.GetBestMapForUnit = function() return 1453 end
local function show(lbl)
  ns:Refresh(); RunTimers()
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
    for _, t in ipairs(list) do if t.id == "learn:ALCHEMY:Greater Mana Potion" then
      print("-- " .. lbl .. ": " .. t.title .. " | " .. tostring(t.zone) .. (t.blocked and (" | BLOCKED " .. t.blocked) or "")); print("   " .. t.detail:gsub("\n", "\n   ")) end end
  end
end
show("before visiting a trainer")
-- simulate opening Lilyssia's trainer window (doesn't teach it)
UnitName = function() return "Lilyssia Nightbreeze" end
GetNumTrainerServices = function() return 2 end
GetTrainerServiceInfo = function(i) return ({ "Mana Potion", "Elixir of Agility" })[i], nil, "used" end
GetTrainerServiceSkillReq = function(i) return "Alchemy", ({ 160, 195 })[i], true end
ns.Trainers:Scan(); RunTimers()
show("after visiting Lilyssia")
print(ns.Diagnostics:Report():match("%-%- Trainers seen %-%-.-\n\n"))
print("END6")
print("\n==== tabs ====")
ns.UI:Show()
print("default tab:", ns.UI.tab)
for _, k in ipairs({ "PLAN", "PROF", "CLASS", "BOOKS", "CAMPING" }) do
  ns.UI:SelectTab(k)
  local labels = {}
  for _, b in ipairs(_G.JA_Dashboard.tabs) do if b:IsShown() then labels[#labels + 1] = (b.text:GetText() or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end end
  print(("  %-8s ok   tabs: %s"):format(k, table.concat(labels, " | ")))
end
ns.db.showBooks = false; ns.UI:SelectTab("BOOKS"); print("books disabled -> tab:", ns.UI.tab)
ns.db.showBooks = true
SlashCmdList.JOURNALASSIST("camping"); print("/ja camping -> tab:", ns.UI.tab)
ns.UI:SetCompact(true); ns.UI:SetCompact(false)
print("END7")
print("\n==== arrow to Ainethil while in Darnassus ====")
ns.db.trainerData = {}
C_Map.GetBestMapForUnit = function() return 1457 end
C_Map.GetMapInfo = (function(orig) return function(id) if id == 1457 then return { name = "Darnassus", mapType = 3, parentMapID = 1414 } end return orig(id) end end)(C_Map.GetMapInfo)
HAS_TOMTOM = true; TOMTOM_LOG = {}
ns:Refresh(); RunTimers()
for _, t in ipairs(ns.Planner.ordered) do if t.id == "learn:ALCHEMY:Greater Mana Potion" then ns.Planner:Select(t.id) end end
RunTimers()
print("active:", ns.Planner.active and ns.Planner.active.title)
ns.Navigation:SetArrowMode(true); RunTimers()
print("tomtom:", table.concat(TOMTOM_LOG, " | "))
print("guidance:", ns.Navigation:GuidanceText())
print("END8")
print("\n==== wowhead data: first aid at 147 in Stormwind ====")
C_Map.GetBestMapForUnit = function() return 1453 end
ns.char.recipes.FIRSTAID.list[7928] = { name = "Silk Bandage", learned = false, reagents = {}, source = "Trainer" }
ns:Refresh(); RunTimers()
for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
  for _, t in ipairs(list) do if t.id:find("^learn:") then print("  " .. t.title .. " | " .. tostring(t.zone) .. (t.blocked and (" | " .. t.blocked) or "")); print("     " .. t.detail:gsub("\n", "\n     ")) end end
end
print("END9")
print("\n==== auctionator prices ====")
Auctionator = { API = { v1 = {
  GetAuctionPriceByItemID = function(caller, id) assert(caller == "JournalAssistant") return ({ [3821] = 4500, [3820] = 1200, [16084] = 25000 })[id] end,
  GetAuctionAgeByItemID = function(caller, id) return ({ [3821] = 2 })[id] end,
  GetVendorPriceByItemID = function(caller, id) return ({ [3371] = 400 })[id] end,
  RegisterForDBUpdate = function(caller, cb) PRICE_CB = cb end,
} } }
ns.Prices:Init()
UnitLevel = function() return 27 end; C_Map.GetBestMapForUnit = function() return 1437 end
COUNTS[3820] = 0; COUNTS[3371] = 0; COUNTS[3821] = 3; ns.Inventory:MarkDirty()
SetSkill(1, 178); SetSkill(2, 201)
C_TradeSkillUI.GetProfessionInfoBySkillLineID = function(id) if id == 129 then return { skillLevel = 147, maxSkillLevel = 150, professionName = "First Aid" } end return {} end
ns.char.profCache.FIRSTAID = nil
PRICE_CB(); RunTimers()
for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
  for _, t in ipairs(list) do if t.cost or (t.costMissing and #t.costMissing > 0) then
    print(("  %s | %s"):format(t.title, ns.UI.CostText(t):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")))
    for _, l in ipairs(t.costLines or {}) do print("      " .. l) end
    if t.costMissing and #t.costMissing > 0 then print("      no price: " .. table.concat(t.costMissing, ", ")) end
  end end
end
ns.UI:Show(); ns.UI:Refresh(); ns.UI.TaskTooltip(UIParent, ns.Planner.ordered[1])
print("END10")
print("\n==== cooking omelet step ====")
ITEMS[3685] = "Raptor Egg"; ITEMS[2692] = "Hot Spices"
COUNTS[3685] = 0; COUNTS[2692] = 0
ns.char.recipes.COOKING = { key = "COOKING", scannedSkill = 150, scannedMax = 225, list = {
  [3397] = { name = "Curiously Tasty Omelet", learned = true, diff = "optimal", reagents = { { itemID = 3685, name = "Raptor Egg", qty = 1 }, { itemID = 2692, name = "Hot Spices", qty = 1 } } },
  [301] = { name = "Rockscale Cod", learned = true, diff = "medium", reagents = {} } } }
local cookIdx = 5
local function setCook(skill, diff)
  local base = GetProfessionInfo
  PROFSKILL = skill
  ns.char.recipes.COOKING.list[3397].diff = diff; ns.char.recipes.COOKING.scannedSkill = skill
  ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers()
end
GetProfessionInfo = (function(orig) return function(i) if i == 5 then return "Cooking", "i", PROFSKILL, 225, 0, 0, 185, 0 end return orig(i) end end)(GetProfessionInfo)
local function show(lbl)
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
    for _, t in ipairs(list) do
      if t.prof == "COOKING" and t.kind == "craft" then print("-- " .. lbl .. ": " .. t.title); print("   " .. t.detail:match("Shopping list.-\n(.-)\nColour"):gsub("\n", "\n   ")) end
      if t.forSteps then print("   supplier: " .. t.title .. "  [for: " .. table.concat(t.forSteps, ", ") .. "]") end
    end
  end
end
setCook(150, "optimal"); show("at 150, no eggs")
COUNTS[3685] = 30; COUNTS[2692] = 30; setCook(150, "optimal"); show("bought 30/30")
COUNTS[3685] = 18; COUNTS[2692] = 18; setCook(160, "medium"); show("at 160 after 12 crafts, now yellow")
COUNTS[3685] = 3; COUNTS[2692] = 3; setCook(172, "easy"); show("at 172, green")
setCook(175, "easy"); show("at 175 step done")
print("END11")
print("\n==== craft focus ====")
COUNTS[3685] = 0; COUNTS[2692] = 0; COUNTS[2592] = 40
ns.char.focusCraft = nil
setCook(150, "optimal")
local function showFocus(lbl)
  print("-- " .. lbl)
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
    for _, t in ipairs(list) do
      if t.kind == "craft" then print(("   %s %s%s"):format(t.focus and "[FOCUS]" or "[queued]", t.title, t.blocked and (" -- " .. t.blocked) or "")) end
      if t.kind == "obtain" and t.forSteps then print("   buy: " .. t.title .. " [for " .. table.concat(t.forSteps, ", ") .. "]") end
    end
  end
end
showFocus("auto focus")
local cookTask; for _, t in ipairs(ns.Planner.blocked) do if t.queued and t.prof == "COOKING" then cookTask = t end end
if cookTask then ns.ProfPlan:SetFocus(cookTask.id); RunTimers(); showFocus("after clicking the Cooking step") end
print("END12")
print("\n==== pause professions ====")
local function profCounts()
  local c = {}
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do for _, t in ipairs(list) do if t.prof then c[t.prof] = (c[t.prof] or 0) + 1 end end end
  local out = {}; for k, v in pairs(c) do out[#out + 1] = k .. "=" .. v end; table.sort(out); return table.concat(out, " ")
end
ns:Refresh(); RunTimers(); print("all on:      " .. profCounts())
SlashCmdList.JOURNALASSIST("pause herbalism"); RunTimers(); print("herb paused: " .. profCounts())
local herbObtain = {}; for _, t in ipairs(ns.Planner.ordered) do if t.kind == "obtain" and t.title:find("Stranglekelp") then herbObtain[#herbObtain + 1] = t.title end end
print("   herbs now bought: " .. table.concat(herbObtain, "; "))
ns:TogglePaused("COOKING"); RunTimers(); print("+cooking paused: " .. profCounts() .. "  objective: " .. ns.Planner.objectives.COOKING.text)
ns.UI:Show(); ns.UI:SelectTab("PROF")
ns:TogglePaused("HERBALISM"); ns:TogglePaused("COOKING"); RunTimers(); print("back on:     " .. profCounts())
print("END13")
print("\n==== first aid 153: healing potion committed, silk bandage learned later ====")
C_TradeSkillUI.GetProfessionInfoBySkillLineID = function(id) if id == 129 then return { skillLevel = 153, maxSkillLevel = 225, professionName = "First Aid" } end return {} end
ns.char.profCache.FIRSTAID = nil
ITEMS[4306] = "Silk Cloth"; ITEMS[2450] = "Briarthorn"; ITEMS[2453] = "Bruiseweed"; ITEMS[3371] = "Leaded Vial"
COUNTS[4306] = 0; COUNTS[2450] = 27; COUNTS[2453] = 27; COUNTS[3371] = 27; COUNTS[2692] = 27
ns.char.recipes.FIRSTAID = { key = "FIRSTAID", scannedSkill = 153, scannedMax = 225, list = {
  [929] = { name = "Healing Potion", learned = true, diff = "optimal", reagents = { { itemID = 2453, name = "Bruiseweed", qty = 1 }, { itemID = 2450, name = "Briarthorn", qty = 1 }, { itemID = 3371, name = "Leaded Vial", qty = 1 } } },
  [7928] = { name = "Silk Bandage", learned = false, diff = "optimal", reagents = { { itemID = 4306, name = "Silk Cloth", qty = 1 } } } } }
ns.char.taskState["craftplan:FIRSTAID"] = { recipe = 929, base = 150, goal = 175, startDiff = "optimal", ups = 1 }
ns.char.focusCraft = nil
ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers()
local function fa(lbl)
  print("-- " .. lbl)
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do for _, t in ipairs(list) do
    if t.prof == "FIRSTAID" and (t.kind == "craft" or t.id:find("^learn:")) then print("   " .. t.title); if t.kind == "craft" then print("     " .. t.detail:gsub("\n", "\n     ")) end end
  end end
end
fa("silk not learned (healing potion step kept, but short)")
ns.char.recipes.FIRSTAID.list[7928].learned = true
ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers()
fa("silk learned")
print("END14")
print("\n==== class quest: tick 'Add to plan' ====")
UnitLevel = function() return 28 end; C_Map.GetBestMapForUnit = function() return 1453 end
DONEQ[1698] = nil; DONEQ[1699] = nil; DONEQ[1702] = nil
ns.char.questDone = {}; ns.char.tracked = {}
ns:Refresh(); RunTimers()
local g = ns.Planner.groups.CLASS
local pick
for _, t in ipairs(g.active) do if t.id == "class:war20" then pick = t end end
print("group row:", pick and pick.title, "tracked:", tostring(pick and pick.tracked))
ns.Planner:SetTracked("class:war20", true); RunTimers()
local function planLines()
  for _, t in ipairs(ns.Planner.ordered) do if t.id:find("^class:") then print("   PLAN " .. (t.order or "?") .. ". " .. t.title .. " | " .. tostring(t.zone)) end end
  for _, t in ipairs(ns.Planner.blocked) do if t.id:find("^class:") then print("   LATER " .. t.title .. " -- " .. t.blocked) end end
  print("   active: " .. (ns.Planner.active and ns.Planner.active.title or "none"))
  for _, t in ipairs(ns.Planner.groups.CLASS.active) do if t.id == "class:war20" then print("   class tab: tracked=" .. tostring(t.tracked) .. " still listed") end end
end
planLines()
ns.UI:Show(); ns.UI:SelectTab("CLASS"); ns.UI:Refresh()
print("-- tick step 1 done in the plan")
ns.Planner:SetDone("class:war20:step:1", true); RunTimers(); planLines()
print("-- untrack")
ns.Planner:SetTracked("class:war20", false); RunTimers(); planLines()
print("END15")
print("\n==== Fire Hardened Mail in log, 50/50 fangs, level 28 in Stormwind ====")
UnitLevel = function() return 28 end; C_Map.GetBestMapForUnit = function() return 1453 end
DONEQ[1698] = true; DONEQ[1699] = true; DONEQ[1702] = true
C_QuestLog.GetInfo = function(i) return { title = "Fire Hardened Mail", questID = 1701 } end
ITEMS[6838] = "Scorched Spider Fang"; ITEMS[6839] = "Charred Horn"; ITEMS[6840] = "Galvanized Horn"; ITEMS[6841] = "Vial of Phlogiston"
COUNTS[6838] = 50; COUNTS[6839] = 0; COUNTS[6840] = 0; COUNTS[6841] = 0
ns.char.tracked = {}; ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers()
for _, t in ipairs(ns.Planner.groups.CLASS.active) do if t.id == "class:war28mail" then print("class tab row: " .. t.title .. " -> " .. tostring(t.zone) .. (t.dest and (" " .. t.dest.x .. "," .. t.dest.y) or "")); print("   " .. t.detail:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\n", "\n   ")) end end
-- an old skipped state comes back as Off
ns.char.taskState["class:war28mail"] = { skipped = true }
ns.Planner:SetTracked("class:war28mail", true); RunTimers()
local function planQ()
  for _, t in ipairs(ns.Planner.ordered) do if t.id:find("^class:war28") then print("   PLAN " .. t.order .. ". " .. t.title .. " | " .. tostring(t.zone) .. " | " .. (t.progressText or "") .. (t.caution and (" | caution: " .. t.caution) or "")) end end
  for _, t in ipairs(ns.Planner.blocked) do if t.id:find("^class:war28") then print("   LATER " .. t.title .. " -- " .. t.blocked) end end
  print("   active: " .. (ns.Planner.active and ns.Planner.active.title or "none") .. " | dest " .. tostring(ns.Planner.active and ns.Planner.active.dest and ns.Planner.active.dest.mapID))
end
planQ()
print("-- all items collected")
COUNTS[6839] = 12; COUNTS[6840] = 1; COUNTS[6841] = 1; ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers(); planQ()
ns.UI:Show(); ns.UI:SelectTab("CLASS"); ns.UI:Refresh(); ns.UI:SelectTab("PROF"); ns.UI:Refresh()
print("END16")
print("\n==== generic quest info: kill objective from the quest log (The Affray) ====")
UnitLevel = function() return 30 end; C_Map.GetBestMapForUnit = function() return 1413 end
REAL_QI = { [1718] = ns.Data.questInfo[1718], [1719] = ns.Data.questInfo[1719] } -- restored in END22
ns.Data.questInfo[1718] = { start = { npc = "Baltus Fowler", zone = "Undercity", x = 47.2, y = 17 }, finish = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 } }
ns.Data.questInfo[1719] = { start = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 }, finish = { npc = "Klannoc Macleod", zone = "The Barrens", x = 68.6, y = 49 },
  obj = { { kill = 6238, name = "Big Will", qty = 1, zone = "The Barrens", x = 68.6, y = 48.6, areaMin = 30 }, { item = 3901, name = "Bloodscalp Tusk", qty = 3, area = 33, x = 30, y = 20 } } }
C_Map.GetAreaInfo = (function(orig) return function(id) if id == 33 then return "Stranglethorn Vale" end return orig(id) end end)(C_Map.GetAreaInfo)
DONEQ[1718] = true
local logState = { { text = "Big Will slain: 0/1", finished = false, numFulfilled = 0, numRequired = 1 }, { text = "Bloodscalp Tusk: 1/3", finished = false, numFulfilled = 1, numRequired = 3 } }
C_QuestLog.GetInfo = function(i) return { title = "The Affray", questID = 1719 } end
C_QuestLog.GetQuestObjectives = function(id) if id == 1719 then return logState end return {} end
KNOWN[2458] = nil
ns.char.tracked = {}
ns.Planner:SetTracked("class:war30berserk", true)
ns:Refresh(); RunTimers()
local key
for _, g in ipairs({ ns.Planner.groups.CLASS.active, ns.Planner.groups.CLASS.blocked }) do for _, t in ipairs(g) do if t.id == "class:war30berserk" then key = t.id; print("row: " .. t.id .. " " .. t.title .. " -> " .. tostring(t.zone)) end end end
local function pq(lbl)
  print("-- " .. lbl)
  for _, t in ipairs(ns.Planner.ordered) do if t.id:find("^class:") then print("   PLAN " .. t.title .. " | " .. tostring(t.zone) .. " | " .. (t.progressText or "")) end end
  for _, t in ipairs(ns.Planner.blocked) do if t.id:find("^class:") then print("   LATER " .. t.title .. " | " .. tostring(t.zone) .. " -- " .. t.blocked) end end
end
ns.Planner:SetTracked("class:war30berserk", true); RunTimers()
pq("in log, 0/1 kill, 1/3 tusks")
logState[1].numFulfilled = 1; logState[1].finished = true; logState[2].numFulfilled = 3; logState[2].finished = true
ns:Refresh(); RunTimers(); pq("objectives done")
print("END17")

print("\n==== stale 'turned in' flag for Fire Hardened Mail (still in log) + Completed list ====")
UnitLevel = function() return 28 end; C_Map.GetBestMapForUnit = function() return 1453 end
DONEQ[1698] = true; DONEQ[1699] = true; DONEQ[1702] = true
C_QuestLog.GetQuestObjectives = function() return {} end
C_QuestLog.GetInfo = function(i) return { title = "Fire Hardened Mail", questID = 1701 } end
ns.char.questDone["id:1701"] = true
ns.char.tracked = { ["class:war28mail"] = true }
local chat = 0
local oldPrint = ns.Print; ns.Print = function(...) chat = chat + 1; oldPrint(...) end
ns:Refresh(); RunTimers()
local function where(id)
  local g = ns.Planner.groups.CLASS
  for _, k in ipairs({ "active", "blocked", "done", "skipped" }) do for _, t in ipairs(g[k]) do if t.id == id then return k end end end
  return "missing"
end
print("in log + stale flag -> list: " .. where("class:war28mail") .. "  flag now: " .. tostring(ns.char.questDone["id:1701"]))
print("completed (shield chain) -> list: " .. where("class:war20"))
-- really turned in: not in the log any more, server says completed
C_QuestLog.GetInfo = function(i) return { title = "Something else", questID = 1 } end
DONEQ[1701] = true; ns:Refresh(); RunTimers()
print("turned in -> list: " .. where("class:war28mail"))
-- a chain only flagged by us (not the server): right-click puts it back
DONEQ[1701] = nil; ns.char.questDone["id:1701"] = true; ns:Refresh(); RunTimers()
print("our flag only -> list: " .. where("class:war28mail"))
ns.Planner:SetDone("class:war28mail", false); RunTimers()
print("after right-click -> list: " .. where("class:war28mail") .. "  flag: " .. tostring(ns.char.questDone["id:1701"]))
ns.UI:Show(); ns.UI:SelectTab("CLASS"); ns.char.collapsed["done:CLASS"] = false; ns.UI:Refresh()
ns.Print = oldPrint
print("END18")

print("\n==== warrior follow-ups: race and prerequisite (Human, level 28) ====")
UnitLevel = function() return 28 end; C_Map.GetBestMapForUnit = function() return 1453 end
C_QuestLog.GetInfo = function(i) return { title = "Something else", questID = 1 } end
DONEQ[1698] = true; DONEQ[1699] = true; DONEQ[1702] = true; DONEQ[1701] = nil
ns.char.questDone = {}; ns.char.tracked = {}
local function where18(id)
  local g = ns.Planner.groups.CLASS
  for _, k in ipairs({ "active", "blocked", "done" }) do for _, t in ipairs(g[k]) do if t.id == id then return k .. (t.blocked and (" (" .. t.blocked .. ")") or "") end end end
  return "not listed"
end
ns:Refresh(); RunTimers()
for _, id in ipairs({ "class:war28mail", "class:war28coif", "class:war28mathiel", "class:war28klock" }) do print("  before 1701: " .. id .. " -> " .. where18(id)) end
DONEQ[1701] = true; ns:Refresh(); RunTimers()
for _, id in ipairs({ "class:war28coif", "class:war28mathiel", "class:war28klock" }) do print("  after 1701:  " .. id .. " -> " .. where18(id)) end
print("END19")

print("\n==== Burning Blood: 20 vials + 1 Burning Rock (Human warrior, level 29) ====")
UnitLevel = function() return 29 end; C_Map.GetBestMapForUnit = function() return 1431 end
DONEQ[1701] = true; DONEQ[1700] = true
ns.char.questDone = {}; ns.char.tracked = { ["class:war28coif"] = true }
local bbLog = { { text = "Burning Blood: 0/20", finished = false, numFulfilled = 0, numRequired = 20 },
                { text = "Burning Rock: 0/1", finished = false, numFulfilled = 0, numRequired = 1 } }
C_QuestLog.GetInfo = function(i) return { title = "Burning Blood", questID = 1705 } end
C_QuestLog.GetQuestObjectives = function(id) if id == 1705 then return bbLog end return {} end
local function pbb(lbl)
  print("-- " .. lbl)
  for _, t in ipairs(ns.Planner.ordered) do if t.id:find("^class:war28coif") then print("   PLAN " .. t.title .. (t.caution and (" | caution: " .. t.caution) or "")) end end
  for _, t in ipairs(ns.Planner.blocked) do if t.id:find("^class:war28coif") then print("   LATER " .. t.title .. " -- " .. t.blocked) end end
  local g = ns.Planner.groups.CLASS
  for _, k in ipairs({ "active", "blocked", "done" }) do for _, t in ipairs(g[k]) do if t.id == "class:war28coif" then print("   list: " .. k) end end end
end
COUNTS[6844] = 5; bbLog[1].numFulfilled = 5; bbLog[1].text = "Burning Blood: 5/20"
ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers(); pbb("5/20 blood, no rock")
COUNTS[6844] = 20; bbLog[1].numFulfilled = 20; bbLog[1].finished = true; bbLog[1].text = "Burning Blood: 20/20"
ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers(); pbb("20/20 blood, no rock")
print("-- quest log only lists the first objective")
C_QuestLog.GetQuestObjectives = function(id) if id == 1705 then return { bbLog[1] } end return {} end
ns:Refresh(); RunTimers(); pbb("20/20 blood, log has 1 objective")
print("END20")

print("\n==== Mithril Head Trout: buy, use from bags, learned (Cooking 180) ====")
UnitLevel = function() return 29 end; C_Map.GetBestMapForUnit = function() return 1453 end
ITEMS[17062] = "Recipe: Mithril Head Trout"; COUNTS[17062] = 0
ns.char.recipes.COOKING = { key = "COOKING", scannedSkill = 180, scannedMax = 225, list = {
  [3397] = { name = "Curiously Tasty Omelet", learned = true, diff = "trivial", reagents = {} } } }
PROFSKILL = 180
local function trout(lbl)
  print("-- " .. lbl)
  local n = 0
  for _, list in ipairs({ ns.Planner.ordered, ns.Planner.blocked }) do
    for _, t in ipairs(list) do
      if t.id:find("^learn:COOKING:Mithril") then n = n + 1; print("   " .. t.title .. (t.blocked and (" -- " .. t.blocked) or "")) end
    end
  end
  print("   trout tasks: " .. n)
end
ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers(); trout("not bought")
COUNTS[17062] = 1; ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers(); trout("recipe in bags")
COUNTS[17062] = 0; KNOWN[20916] = true; ns.Inventory:MarkDirty(); ns:Refresh(); RunTimers(); trout("learned (window not opened)")
KNOWN[20916] = nil
print("END21")

print("\n==== warrior follow-ups after the stance spell + Whirlwind chain (Human, level 30) ====")
UnitLevel = function() return 30 end; C_Map.GetBestMapForUnit = function() return 1453 end
C_QuestLog.GetInfo = function(i) return { title = "Something else", questID = 1 } end
C_QuestLog.GetQuestObjectives = function() return {} end
ns.char.questDone = {}; ns.char.tracked = {}
for _, id in ipairs({ 1638, 1639, 1640, 1665 }) do DONEQ[id] = true end
DONEQ[1718] = nil; DONEQ[1719] = nil -- set by END17
for id, v in pairs(REAL_QI) do ns.Data.questInfo[id] = v end
KNOWN[71] = true; KNOWN[2458] = nil
local function row22(id)
  local g = ns.Planner.groups.CLASS
  for _, k in ipairs({ "active", "blocked", "done" }) do for _, t in ipairs(g[k]) do if t.id == id then
    return k .. " | " .. t.title .. " | npc " .. tostring(t.npc) .. " | " .. tostring(t.zone) .. (t.blocked and (" -- " .. t.blocked) or "") end end end
  return "not listed"
end
ns:Refresh(); RunTimers()
print("defensive stance known, 1665 done: " .. row22("class:war10human"))
print("islander not started: " .. row22("class:war30berserk"))
DONEQ[1718] = true; DONEQ[1719] = true; DONEQ[1791] = true; KNOWN[2458] = true
ns:Refresh(); RunTimers()
print("berserker known, windwatcher done: " .. row22("class:war30berserk"))
C_QuestLog.GetInfo = function(i) return { title = "Cyclonian", questID = 1712 } end
ns:Refresh(); RunTimers()
print("cyclonian accepted: " .. row22("class:war30berserk"))
for _, id in ipairs({ 1666, 1667, 1714, 1712, 1713, 1718, 1719, 1791 }) do DONEQ[id] = nil end
KNOWN[71] = nil; KNOWN[2458] = nil
print("END22")
