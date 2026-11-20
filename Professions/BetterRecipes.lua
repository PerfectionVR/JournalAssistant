-- Journal Assistant - Better recipes to learn or buy
--
-- Guide recipes you do not know yet: where to learn / buy them (Wowhead data,
-- recipe vendors, trainers you visited, client source text).

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, prio, now, SafetyFactor, CautionText, Hub = U.AddTask, U.prio, U.now, U.SafetyFactor, U.CautionText, U.Hub

local function KnownRecipe(cache, name)
    local lname = string.lower(name)
    for _, r in pairs(cache.list) do
        if r.learned and r.name and string.lower(r.name) == lname then return true end
    end
    return false
end

local function UnlearnedByName(cache, name)
    local lname = string.lower(name)
    for _, r in pairs(cache.list) do
        if not r.learned and r.name and string.lower(r.name) == lname then return r end
    end
end

local function VendorFor(profKey, name)
    local lname = string.lower(name)
    for _, v in ipairs((ns.Data.recipeVendors or {})[profKey] or {}) do
        if string.lower(v.recipe) == lname then return v end
    end
end

-- "Zone: Ashenvale" inside the client's recipe source text
local function ParseSourceZone(txt)
    if not txt then return nil end
    local z = txt:match("Zone:%s*(.-)%s+%u[%a ]-:") or txt:match("Zone:%s*(.-)%s*$")
    if z and ns.Data.zones[z] then return z end
    return nil
end

-- Nearest safe trainer that teaches recipes at `skillNeeded` (Expert/Artisan
-- recipes come from the trainers that teach that rank).
local function TrainerFor(ctx, p, skillNeeded, exclude)
    local ranks = ns.Data.ranks[p.key]
    local list
    if ranks then
        if skillNeeded >= 225 and ranks[3] and ranks[3].method == "trainer" then list = ranks[3].sources
        elseif skillNeeded >= 150 and ranks[2] and ranks[2].method == "trainer" then list = ranks[2].sources end
    end
    list = ns.Data.RankSourcesFor({ sources = list or ns.Data.trainers[p.key] or {} }, ctx.faction)
    local best, bestScore
    for _, s in ipairs(list) do
        if not (exclude and exclude[s.npc]) then
            local score = SafetyFactor(s.zone, ctx.level, s.area and s.area.min) / (1 + ns.Routes:Distance(ctx.curZone, s.zone))
            if not bestScore or score > bestScore then best, bestScore = s, score end
        end
    end
    return best
end

-- Point out recipes that are better than what you know (Forever guide recipe for
-- your skill band, guide vendor recipes) and where to get each one. Sources, most
-- reliable first: guide vendor/drop/quest data, a trainer you visited that teaches
-- it (Trainers.lua), your client's source text, then a guessed trainer - never one
-- you visited that does NOT teach it.
function PP:AddBetterRecipes(ctx, p, cache, goalCap, best)
    local seen, cands = {}, {}
    local function add(c)
        local k = string.lower(c.name)
        if seen[k] or KnownRecipe(cache, c.name) then return end
        seen[k] = true
        cands[#cands + 1] = c
    end
    for _, s in ipairs((ns.Data.guideRecipes or {})[p.key] or {}) do
        if s[2] - p.skill >= 8 and s[1] <= p.skill + 10 and s[1] < goalCap then
            add({ name = s[3], from = s[1], to = s[2], guide = true })
        end
    end
    for _, v in ipairs((ns.Data.recipeVendors or {})[p.key] or {}) do
        if p.skill >= v.skill - 10 and p.skill < v.skill + 30 and v.skill < goalCap + 10 then
            add({ name = v.recipe, from = v.skill, to = v.skill + 30, guide = true })
        end
    end
    -- Note: the colour the client reports for UNLEARNED recipes is not usable on
    -- Forever, so unlearned recipes are only suggested when a Forever guide names them.

    local _, unlearnedCount = ns.Recipes:Summary(p.key)
    local hub = Hub(ctx)
    for _, c in ipairs(cands) do
        local v = VendorFor(p.key, c.name)
        local scanned = UnlearnedByName(cache, c.name)
        -- Your client lists unlearned recipes too: a guide recipe missing from that
        -- list most likely does not exist on Forever, so it is not suggested.
        local missing = not v and not scanned and (unlearnedCount or 0) > 0
        if not missing then
            local teacher, notHere = nil, {}
            if ns.Trainers then teacher, notHere = ns.Trainers:WhoTeaches(p.key, c.name) end
            local wh = ns.Data.recipeTeachers and ns.Data.recipeTeachers[string.lower(c.name)]
            if wh and wh.req and not teacher then c.from = wh.req end
            local clientText = scanned and scanned.source and scanned.source ~= "" and scanned.source or nil
            -- Wowhead-verified recipe item: nearest safe vendor of your faction, else its drop sources
            local whItem
            if wh and wh.items and wh.items[1] then
                local it = wh.items[1]
                local fl = ctx.faction == "Horde" and "H" or "A"
                local bestV, bestS
                for _, n in ipairs(it.soldBy or {}) do
                    if (n[4] or "AH"):find(fl, 1, true) or n[4] == "" then
                        local z = ns.Routes:NpcZone(n)
                        local sc = SafetyFactor(z, ctx.level) / (1 + ns.Routes:Distance(ctx.curZone, z)) * (n[5] and 1.2 or 1)
                        if not bestS or sc > bestS then bestV, bestS = n, sc end
                    end
                end
                if bestV then
                    whItem = { kind = "vendor-wowhead", npc = bestV[2], zone = ns.Routes:NpcZone(bestV), x = bestV[5], y = bestV[6], mapID = bestV[7], item = it.name, it = it }
                elseif it.droppedBy and it.droppedBy[1] then
                    local d = it.droppedBy[1]
                    whItem = { kind = "drop", npc = d[2], zone = d[3] or ns.Routes:AreaName(d[6]), item = it.name, it = it }
                end
            end
            local src
            if whItem then
                src = whItem
            elseif v then
                src = { kind = v.kind or "vendor", npc = v.npc, zone = v.zone, x = v.x, y = v.y, note = v.note, item = v.item, alt = v.alt }
            elseif teacher then
                local t = teacher.trainer
                src = { kind = "trainer-seen", npc = t.npc, zone = t.zone, x = t.x, y = t.y, mapID = t.mapID, req = teacher.req }
                if teacher.req then c.from = teacher.req end
            elseif wh and wh.npcs then
                -- verified on Wowhead Forever: pick the safest / nearest teacher of your faction
                local fl = ctx.faction == "Horde" and "H" or "A"
                local bestT, bestS
                for _, n in ipairs(wh.npcs) do
                    if n[4]:find(fl, 1, true) and not notHere[n[2]] then
                        local z = ns.Routes:NpcZone(n)
                        local sc = SafetyFactor(z, ctx.level) / (1 + ns.Routes:Distance(ctx.curZone, z)) * (n[5] and 1.2 or 1)
                        if not bestS or sc > bestS then bestT, bestS = n, sc end
                    end
                end
                src = { kind = "trainer-wowhead", npc = bestT and bestT[2], zone = bestT and ns.Routes:NpcZone(bestT), none = bestT == nil, wh = wh, fl = fl,
                        x = bestT and bestT[5], y = bestT and bestT[6], mapID = bestT and bestT[7] }
            elseif clientText and not clientText:find("Trainer") then
                src = { kind = "client", text = clientText, zone = ParseSourceZone(clientText) }
            else
                local t = TrainerFor(ctx, p, c.from or p.skill, notHere)
                src = { kind = "trainer", npc = t and t.npc, zone = t and t.zone, x = t and t.x, y = t and t.y, note = t and t.note,
                        none = t == nil }
            end
            local visited = {}
            for name in pairs(notHere or {}) do visited[#visited + 1] = name end
            table.sort(visited)

            local upcoming = c.from and p.skill < c.from
            local isTrainer = src.kind == "trainer" or src.kind == "trainer-seen" or src.kind == "trainer-wowhead"
            local caution, safety, effMin = CautionText(src.zone, ctx.level)
            local viaAH = safety == "danger" and not ns.db.allowDangerous and not isTrainer
            local blocked
            if src.none and src.kind == "trainer-wowhead" then
                blocked = "No trainer of your faction teaches it (Wowhead Forever)"
            elseif src.none then
                blocked = ("Trainers you checked (%s) don't teach it - see its source in your %s window"):format(table.concat(visited, ", "), p.name)
            elseif safety == "danger" and not ns.db.allowDangerous and not viaAH then
                blocked = ("Reach level %d first - trainer area too dangerous (you are %d)"):format(effMin or 0, ctx.level)
            elseif upcoming and (isTrainer or not src.zone or src.kind == "drop") then
                blocked = ("Learnable at %s %d (you have %d)"):format(p.name, c.from, p.skill)
            end

            local title
            if viaAH then
                title = ("Buy %s on the Auction House"):format(src.item or ("recipe: " .. c.name))
            elseif isTrainer then
                title = ("Learn %s (%s)"):format(c.name, src.npc or (p.name .. " trainer"))
            elseif src.kind == "drop" then
                title = ("Find %s"):format(src.item or ("recipe: " .. c.name))
            elseif src.kind == "quest" then
                title = ("Quest for %s"):format(src.item or c.name)
            elseif src.kind == "client" then
                title = ("Get recipe: %s"):format(c.name)
            else
                title = ("Buy %s"):format(src.item or ("recipe: " .. c.name))
            end
            if upcoming then title = title .. (" (at %d)"):format(c.from) end

            local lines = {}
            lines[#lines + 1] = ("Forever guide recipe for %s %d-%d."):format(p.name, c.from or 0, c.to or 0)
            if best then
                lines[#lines + 1] = ("Best recipe you know now: %s (%s, ~%.1f skill/craft)."):format(best.r.name or "?", best.diff, best.gain)
            else
                lines[#lines + 1] = "None of your learned recipes gives skill at the moment."
            end
            if src.kind == "trainer-seen" then
                lines[#lines + 1] = ("Taught by %s, %s - seen at their trainer window%s."):format(src.npc, src.zone or "?",
                    src.req and (", requires " .. p.name .. " " .. src.req) or "")
            elseif src.kind == "trainer-wowhead" then
                local all = {}
                for _, n in ipairs(src.wh.npcs) do
                    if n[4]:find(src.fl, 1, true) then all[#all + 1] = n[2] .. " (" .. (ns.Routes:NpcZone(n) or "?") .. ")" end
                end
                lines[#lines + 1] = ("Taught by (Wowhead Forever, requires %s %s): %s."):format(p.name, tostring(src.wh.req or "?"), table.concat(all, ", "))
                if src.npc then lines[#lines + 1] = ("Nearest safe one: %s, %s."):format(src.npc, src.zone) end
            elseif src.kind == "trainer" and src.npc then
                lines[#lines + 1] = ("Probably taught by %s, %s%s (from guides - not checked yet; JA learns what each trainer really teaches when you open their window)."):format(
                    src.npc, src.zone or "?", src.note and (" (" .. src.note .. ")") or "")
            elseif src.kind == "client" then
                lines[#lines + 1] = "Source: " .. src.text
            elseif src.it then
                -- Wowhead-verified recipe item sources
                local sold, drops = {}, {}
                for _, n in ipairs(src.it.soldBy or {}) do sold[#sold + 1] = n[2] .. (ns.Routes:NpcZone(n) and (" (" .. ns.Routes:NpcZone(n) .. ")") or "") end
                for _, d in ipairs(src.it.droppedBy or {}) do drops[#drops + 1] = d[2] .. (d[3] and (" (" .. d[3] .. ")") or "") end
                if #sold > 0 then lines[#lines + 1] = ("%s is sold by (Wowhead Forever): %s."):format(src.item, table.concat(sold, ", ")) end
                if #drops > 0 then lines[#lines + 1] = ("%s drops from (Wowhead Forever): %s."):format(src.item, table.concat(drops, ", ")) end
                if src.kind == "vendor-wowhead" then lines[#lines + 1] = ("Nearest safe vendor: %s, %s."):format(src.npc, src.zone or "?") end
                lines[#lines + 1] = "Recipe items are usually tradeable - check the Auction House too" .. (viaAH and (": the source is too dangerous at your level (" .. (caution or "") .. ")") or "") .. "."
            elseif not isTrainer then
                lines[#lines + 1] = ("%s %s%s%s."):format(src.kind == "drop" and "Drops from" or (src.kind == "quest" and "Quest from" or "Sold by"),
                    src.npc or "?", src.zone and (", " .. src.zone) or "", src.note and (" (" .. src.note .. ")") or "")
                if src.alt then lines[#lines + 1] = "Also: " .. src.alt end
                lines[#lines + 1] = "Recipe items are usually tradeable - check the Auction House too" .. (viaAH and (": the source is too dangerous at your level (" .. (caution or "") .. ")") or "") .. "."
            end
            if #visited > 0 then lines[#lines + 1] = "Not taught by: " .. table.concat(visited, ", ") .. " (checked)." end
            if clientText and src.kind ~= "client" then lines[#lines + 1] = "Your client lists the source as: " .. clientText end

            local improves = (not best) or best.gain < 1
            local zone = viaAH and hub or src.zone
            AddTask(ctx, {
                id = ("learn:%s:%s"):format(p.key, c.name), kind = "obtain", prof = p.key,
                title = title, detail = table.concat(lines, "\n"),
                zone = zone, npc = not viaAH and src.npc or nil,
                dest = (not viaAH and src.x and src.zone) and { zone = src.zone, x = src.x, y = src.y, npc = src.npc, mapID = src.mapID,
                    approx = src.kind ~= "trainer-seen" and src.kind ~= "trainer-wowhead" } or nil,
                blocked = blocked, caution = not viaAH and caution or nil,
                buyItem = (not isTrainer and src.item) and { name = src.item, itemID = src.it and src.it.item, qty = 1 } or nil,
                confidence = (src.kind == "client" or src.kind == "trainer-seen") and "client" or "forever-guide",
                value = (upcoming and 1.5 or (improves and 4.5 or 2.5)) * prio(p.key),
                reasons = { "better recipe from the Forever guide" },
            })
            if zone and not blocked then ctx.rankZones[zone] = true end
        end
    end
end
