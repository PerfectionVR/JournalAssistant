-- Journal Assistant - Library book tasks
--
-- One task per book still to find (safe ones first), the turn-in and the next
-- milestone reward.

local _, ns = ...
local PL = ns.Planner
local GP = ns.GuidePlan
local U = PL.util
local AddTask, prio, SafetyFactor, CautionText = U.AddTask, U.prio, U.SafetyFactor, U.CautionText

function GP:AddBooks(ctx)
    local BK = ns.Books
    if not (BK and ns.db.showBooks) then return end
    BK:Update()
    local lib = ns.Data.librarians[ctx.faction] or ns.Data.librarians.Alliance
    local list = BK:List()
    local inBags, total = {}, #list
    for _, b in ipairs(list) do
        if not BK:IsTurnedIn(b) then
            if BK:InBags(b) then
                inBags[#inBags + 1] = b
            else
                local spots = { { zone = b.zone, x = b.x, y = b.y, note = b.note } }
                if b.alt then spots[2] = b.alt end
                local best, bestScore
                for _, sp in ipairs(spots) do
                    local sc = SafetyFactor(sp.zone, ctx.level, b.area) / (1 + ns.Routes:Distance(ctx.curZone, sp.zone))
                    if not bestScore or sc > bestScore then best, bestScore = sp, sc end
                end
                local caution, safety, effMin = CautionText(best.zone, ctx.level, b.area, b.area and "Guarded room")
                local blocked
                if safety == "danger" and not ns.db.allowDangerous then
                    blocked = ("Reach level %d (you are %d)"):format(effMin or 0, ctx.level)
                end
                local lines = { best.note .. "." }
                if b.alt then lines[#lines + 1] = ("Also spawns in %s (%s) - only one copy counts."):format(b.alt.zone, b.alt.note) end
                if b.hostileFor == ctx.faction then lines[#lines + 1] = "Inside an enemy-faction town: watch out for guards." end
                lines[#lines + 1] = ("Turn in to %s, %s (%s)."):format(lib.npc, lib.zone, lib.note)
                AddTask(ctx, {
                    id = "book:" .. b.item, kind = "obtain", prof = "BOOKS", group = "BOOKS",
                    title = "Book: " .. b.name, detail = table.concat(lines, "\n"),
                    zone = best.zone, dest = { zone = best.zone, x = best.x, y = best.y, approx = true },
                    blocked = blocked, caution = not blocked and caution or nil,
                    confidence = "forever-guide",
                    value = 3 * prio("BOOKS") / (1 + 0.3 * ns.Routes:Distance(ctx.curZone, best.zone)), -- nearest first
                    chainLevel = blocked and (effMin or 0) or nil,
                    reasons = { "Library book" },
                    bookItem = b.item,
                })
            end
        end
    end
    local turned = BK:TurnedInCount()
    ctx.bookSummary = { turned = turned, inBags = #inBags, total = total }
    if #inBags > 0 then
        local names = {}
        for _, b in ipairs(inBags) do names[#names + 1] = b.name end
        AddTask(ctx, {
            id = "book:turnin", kind = "obtain", prof = "BOOKS", group = "BOOKS",
            title = ("Turn in %d library book%s to %s"):format(#inBags, #inBags > 1 and "s" or "", lib.npc),
            detail = ("%s, %s (%s).\nIn your bags: %s"):format(lib.npc, lib.zone, lib.note, table.concat(names, ", ")),
            zone = lib.zone, npc = lib.npc, dest = { zone = lib.zone, x = lib.x, y = lib.y, npc = lib.npc, approx = true },
            confidence = "forever-guide", value = 5 * prio("BOOKS"), reasons = { "books ready to turn in" },
        })
    end
    for _, m in ipairs(ns.Data.bookMilestones or {}) do
        local done = false
        if ns.Has("C_QuestLog", "IsQuestFlaggedCompleted") then
            local ok, v = pcall(C_QuestLog.IsQuestFlaggedCompleted, m.quest)
            done = ok and v
        end
        if not done then
            local have = turned + #inBags
            local blocked
            if ctx.level < m.level then blocked = ("Reach level %d (you are %d)"):format(m.level, ctx.level)
            elseif have < m.books then blocked = ("%d of %d books collected"):format(have, m.books) end
            AddTask(ctx, {
                id = "book:milestone:" .. m.books, kind = "quest", prof = "BOOKS", group = "BOOKS",
                title = ("Reward: %s (%d books)"):format(m.title, m.books),
                detail = ("Reward choice: %s.\nTurn in %d books total (you have %d turned in, %d in bags).%s")
                    :format(m.reward, m.books, turned, #inBags, m.note and ("\n" .. m.note) or ""),
                zone = lib.zone, npc = lib.npc, dest = { zone = lib.zone, x = lib.x, y = lib.y, npc = lib.npc, approx = true },
                blocked = blocked, confidence = "forever-guide", value = 4 * prio("BOOKS"),
                reasons = { "library milestone" },
            })
            break -- only the next milestone
        end
    end
end
