-- Journal Assistant - Crafting steps
--
-- One committed step per profession (recipe, skill range, shopping list), and
-- the focus rule: only one crafting step requests materials at a time.

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, AddDemand, prio, now = U.AddTask, U.AddDemand, U.prio, U.now
local ItemNode, FishZones, NodeHasSafeZone = PP.ItemNode, PP.FishZones, PP.NodeHasSafeZone

function PP:AddCraft(ctx, p, target)
    local goalCap = math.min(target, p.maxSkill)
    if p.skill >= goalCap then return end
    local cache = ns.Recipes:Get(p.key)
    if not cache or not cache.list or not next(cache.list) then
        AddTask(ctx, {
            id = "scan:" .. p.key, kind = "scan", prof = p.key,
            title = ("Open your %s window once"):format(p.name),
            detail = "Lets the planner read your known recipes, their colours and reagents from the client.",
            confidence = "client", value = 5 * prio(p.key),
        })
        return
    end
    local guideSteps, guideFirst = ns.Data.GuideStepsAt(p.key, p.skill)
    local stale = p.skill - (cache.scannedSkill or p.skill)
    local best, bestGuide
    for id, r in pairs(cache.list) do
        if r.learned and r.reagents then
            local diff = ns.Recipes:EffectiveDifficulty(r.diff, stale)
            local gain = ns.Recipes.GAIN[diff] or 0
            if diff == "optimal" and (r.skillUps or 1) > 1 then gain = r.skillUps end
            if gain > 0 then
                local owned, craftable, n, synergy, vendorOnly = 0, math.huge, 0, 0, true
                for _, rg in ipairs(r.reagents) do
                    rg.name = rg.name or ns.Inventory.ItemName(rg.itemID)
                    local have = ns.Inventory:Count(rg)
                    local q = math.max(1, rg.qty or 1)
                    craftable = math.min(craftable, math.floor(have / q))
                    owned = owned + math.min(1, have / (q * 5))
                    n = n + 1
                    local e = ItemNode(rg.name)
                    if e and (ctx.skills[e.prof] or -1) >= e.node.skill and NodeHasSafeZone(e.node, ctx.level) then
                        synergy = synergy + 0.3
                    end
                    if FishZones(rg.name) and ctx.fishing then synergy = synergy + 0.2 end
                    if not ns.Recipes.IsVendorReagent(rg.name) then vendorOnly = false end
                end
                if n == 0 then craftable, owned = 0, 1 else owned = owned / n end
                if craftable == math.huge then craftable = 0 end
                local isGuide = r.name and guideSteps[string.lower(r.name)] ~= nil
                local score = gain * (1 + 0.8 * owned) + synergy + (vendorOnly and n > 0 and 0.2 or 0) + (isGuide and 0.5 or 0)
                local cand = { id = id, r = r, diff = diff, gain = gain, score = score, craftable = craftable, guide = isGuide }
                if not best or score > best.score then best = cand end
                if isGuide and (not bestGuide or score > bestGuide.score) then bestGuide = cand end
            end
        end
    end
    -- A learned recipe the Forever guide uses at this skill always wins over an
    -- off-guide one (which is usually past its range and fades fast). Off-guide
    -- crafts you can already make from your bags are mentioned, never bought for.
    local leftover
    if best and not best.guide and bestGuide then
        if best.craftable > 0 then leftover = best end
        best = bestGuide
    end

    -- Committed step: once a recipe is chosen it is kept until its step ends,
    -- so the shopping list is computed once for the whole step instead of per
    -- 10-point batch (which made you buy materials several times).
    local planKey = "craftplan:" .. p.key
    local plan = ns.char.taskState[planKey]
    if plan and plan.recipe then
        local r = cache.list[plan.recipe]
        local diff = r and r.learned and ns.Recipes:EffectiveDifficulty(r.diff, stale)
        local offGuide = r and r.name and not guideSteps[string.lower(r.name)]
        -- an off-guide step (e.g. committed before the guide moved on) is cut
        -- to 10 points from where you are, so you never buy for 25 more
        if offGuide and plan.goal and plan.goal > p.skill + 10 then
            plan.base, plan.goal, plan.total = p.skill, p.skill + 10, nil
            plan.startDiff = diff or plan.startDiff
        end
        if r and diff and diff ~= "trivial" and p.skill < plan.goal and plan.goal <= goalCap
            and not (offGuide and bestGuide) then
            if not best or best.id ~= plan.recipe then
                local craftable = math.huge
                for _, rg in ipairs(r.reagents or {}) do
                    craftable = math.min(craftable, math.floor(ns.Inventory:Count(rg) / math.max(1, rg.qty or 1)))
                end
                if craftable == math.huge then craftable = 0 end
                best = { id = plan.recipe, r = r, diff = diff, gain = ns.Recipes.GAIN[diff] or 0.25, craftable = craftable,
                         guide = r.name and guideSteps[string.lower(r.name)] ~= nil, committed = true }
            else
                best.committed = true
            end
        else
            plan = nil
            ns.char.taskState[planKey] = nil
        end
    else
        plan = nil
    end

    local guideLine = guideFirst and ("\nForever guide at %d: %s (%d-%d)."):format(p.skill, guideFirst[3], guideFirst[1], guideFirst[2]) or ""

    self:AddBetterRecipes(ctx, p, cache, goalCap, best)

    if not best then
        local trainer = ns.Data.trainers[p.key] and ns.Data.RankSourcesFor({ sources = ns.Data.trainers[p.key] }, ctx.faction)[1]
        local learned, unlearned = ns.Recipes:Summary(p.key)
        AddTask(ctx, {
            id = "train:" .. p.key .. ":" .. p.skill, kind = "rank", prof = p.key,
            title = ("Learn new %s recipes"):format(p.name),
            detail = ("None of your %d learned recipes still gives skill at %d (per last scan). %d known recipes are not learned yet.%s%s")
                :format(learned or 0, p.skill, unlearned or 0,
                    trainer and ("\nTrainer: " .. trainer.npc .. ", " .. trainer.zone) or "", guideLine),
            zone = trainer and trainer.zone,
            dest = trainer and trainer.x and { zone = trainer.zone, x = trainer.x, y = trainer.y, approx = true } or nil,
            confidence = "client", value = 4 * prio(p.key),
        })
        return
    end

    local r = best.r
    -- (Re)commit the step: it ends where the Forever guide moves on from this
    -- recipe, else 25 points later, capped by your target / skill cap.
    if not plan or plan.recipe ~= best.id then
        -- off-guide (or past its guide band): short 10-point step, so you never
        -- stock up for a recipe that is about to turn green / grey
        local stepEnd = (r.name and guideSteps[string.lower(r.name)]) and p.skill + 25 or p.skill + 10
        if r.name then
            for _, s in ipairs((ns.Data.guideRecipes or {})[p.key] or {}) do
                if string.lower(s[3]) == string.lower(r.name) and p.skill < s[2] and s[2] > p.skill then
                    stepEnd = s[2]
                end
            end
        end
        plan = { recipe = best.id, base = p.skill, goal = math.min(goalCap, stepEnd), startDiff = best.diff,
                 ups = (best.diff == "optimal" and (r.skillUps or 1) > 1) and r.skillUps or 1 }
        ns.char.taskState[planKey] = plan
    end
    -- Fixed fade model, decided when the step starts: from orange, ~40% of the
    -- points at 1 skill/craft, 40% at yellow (~0.6), 20% at green (~0.3); from
    -- yellow 70% yellow / 30% green; from green all green. Remaining crafts are
    -- counted along the same model, so the shopping list only shrinks.
    local SEG = { optimal = { { 0.4, 1.0 }, { 0.4, 0.6 }, { 0.2, 0.3 } },
                  medium = { { 0.7, 0.6 }, { 0.3, 0.3 } },
                  easy = { { 1.0, 0.3 } } }
    local function craftsFor(fromSkill)
        local segs = SEG[plan.startDiff or "easy"] or SEG.easy
        local span = plan.goal - plan.base
        local total, pos = 0, plan.base
        for _, sgt in ipairs(segs) do
            local segEnd = pos + span * sgt[1]
            local lo = math.max(pos, fromSkill)
            if segEnd > lo then total = total + (segEnd - lo) / (sgt[2] * (plan.ups or 1)) end
            pos = segEnd
        end
        return math.max(1, math.ceil(total))
    end
    local crafts = craftsFor(p.skill)
    plan.total = plan.total or craftsFor(plan.base)

    local id = ("craft:%s:%s"):format(p.key, tostring(best.id))
    local st = PL:State(id)
    st.goal, st.baseSkill = plan.goal, plan.base
    local tip = ns.Data.tips and ns.Data.tips[p.key]

    local shop = {}
    local t = AddTask(ctx, {
        id = id, kind = "craft", prof = p.key,
        title = ("Craft ~%d x %s (%s %d -> %d)"):format(crafts, r.name or "?", p.name, p.skill, plan.goal),
        detail = "", -- filled below
        materials = {}, recipeName = r.name, crafts = crafts, craftable = best.craftable,
        confidence = "client",
        caution = stale >= 12 and ("Open the " .. p.name .. " window to refresh recipe colours.") or nil,
        value = (best.craftable > 0 and 5 or 3) * prio(p.key),
        metric = { skillKey = p.key, skillGoal = plan.goal, materials = false },
        reasons = { ("%s step %d -> %d"):format(p.name, plan.base, plan.goal) },
        step = { from = plan.base, to = plan.goal, recipe = r.name },
    })
    -- materials are listed here; they only become "demand" (gather / buy tasks)
    -- if this step is the focused one (see PP:ApplyCraftFocus)
    t.pendingDemand = {}
    for _, rg in ipairs(r.reagents) do
        local need = crafts * (rg.qty or 1)
        local mat = { name = rg.name or ns.Inventory.ItemName(rg.itemID) or ("item:" .. tostring(rg.itemID)), itemID = rg.itemID, need = need }
        t.materials[#t.materials + 1] = mat
        t.pendingDemand[#t.pendingDemand + 1] = { rg = rg, need = need, mat = mat,
            reason = ("%s step %d -> %d: ~%d x %s"):format(p.name, plan.base, plan.goal, crafts, r.name or "?") }
        local have = ns.Inventory:Count(rg)
        local d = mat
        shop[#shop + 1] = ("  %s: need %d, have %d%s"):format(d.name, need, have,
            have < need and (" -> get " .. (need - have)) or " (enough)")
    end
    t.detail = ("One step: %s %d -> %d with %s, about %d crafts in total (%d left).\nShopping list for the rest of the step (buy it all at once):\n%s\nColour now: %s. The step keeps this recipe until it is done or turns grey; the estimate already allows for the colour fading from orange to yellow to green.%s%s%s")
        :format(p.name, plan.base, plan.goal, r.name or "?", plan.total, crafts, table.concat(shop, "\n"), best.diff,
            stale >= 12 and ("\nColours estimated: last scanned at " .. tostring(cache.scannedSkill) .. ".") or "",
            (best.guide and "\nThis is the Forever guide recipe for your skill." or guideLine)
                .. (leftover and ("\nOptional: you can already make %d x %s from your bags (%s, still gives skill) - craft those first, but don't buy more for it."):format(
                    leftover.craftable, leftover.r.name or "?", leftover.diff) or ""),
            tip and ("\n" .. tip) or "")
end


---------------------------------------------------------------------------
-- Focus: only ONE crafting step at a time turns its materials into gather /
-- buy tasks, so bags and gold are not spread over several recipes. The others
-- are queued (shown, not requested). The focus stays until its step is done
-- or skipped; you can switch by clicking a queued step.
---------------------------------------------------------------------------
function PP:ApplyCraftFocus(ctx)
    local crafts = {}
    for _, t in ipairs(ctx.tasks) do
        if t.kind == "craft" and t.pendingDemand then crafts[#crafts + 1] = t end
    end
    if #crafts == 0 then return end
    local focus = ns.char.focusCraft and ctx.byId[ns.char.focusCraft]
    local fs = focus and ns.char.taskState[focus.id]
    if focus and (not focus.pendingDemand or (fs and (fs.skipped or (fs.done and fs.manual)))) then focus = nil end
    if not focus then
        local cands = {}
        for _, t in ipairs(crafts) do
            local s = ns.char.taskState[t.id]
            if not (s and (s.skipped or (s.done and s.manual))) then cands[#cands + 1] = t end
        end
        -- prefer a step you can already craft (materials in bags), then priority / value
        table.sort(cands, function(a, b)
            local ca, cb = (a.craftable or 0) > 0, (b.craftable or 0) > 0
            if ca ~= cb then return ca end
            return (a.value or 0) > (b.value or 0)
        end)
        focus = cands[1]
        ns.char.focusCraft = focus and focus.id or nil
    end
    for _, t in ipairs(crafts) do
        if t == focus then
            for _, pd in ipairs(t.pendingDemand) do
                pd.mat.demand = AddDemand(ctx, pd.rg, pd.need, pd.reason, t.id)
            end
            t.focus = true
            t.clickHint = "Focused crafting step - the only one whose materials are requested right now."
            table.insert(t.reasons, 1, "focused crafting step (one at a time)")
        else
            t.queued = true
            t.onClick = function(task) PP:SetFocus(task.id) end
            t.clickHint = "Click: make this the focused crafting step (its materials are then requested instead)"
            t.blocked = ("Queued - focus is %s. Click to focus this step instead"):format(focus and focus.recipeName or "another step")
            t.detail = t.detail .. "\nQueued: its materials are not requested yet, so your bags and gold go to one recipe at a time."
        end
        t.pendingDemand = nil
    end
end

function PP:SetFocus(id)
    ns.char.focusCraft = id
    ns:RequestRefresh("focus")
    local t = PL.byId[id]
    if t then ns.Print("Focused crafting step: " .. t.title) end
end
