-- Journal Assistant - Obtain tasks
--
-- Material demand nothing else covers becomes a vendor / Auction House task.

local _, ns = ...
local PL = ns.Planner
local PP = ns.ProfPlan
local U = PL.util
local AddTask, Hub = U.AddTask, U.Hub
local ItemNode, NodeHasSafeZone = PP.ItemNode, PP.NodeHasSafeZone

function PP:AddObtain(ctx)
    local hub = Hub(ctx)
    for _, lname in ipairs(ctx.demandOrder) do
        local d = ctx.demand[lname]
        local have = ns.Inventory:Count(d)
        if not d.coveredBy and have < d.need then
            local vendor = ns.Recipes.IsVendorReagent(d.name)
            local e = ItemNode(d.name)
            local ah = "Buy on the Auction House" .. (ns.IsAddOnLoaded("Auctionator") and " (Auctionator detected: search the name)." or ".")
            local how
            if vendor then
                how = "Sold by trade-goods / profession supply vendors (e.g. in " .. hub .. ")."
            elseif e and (ctx.skills[e.prof] or -1) < e.node.skill then
                how = ("Gathering it needs %s %d. %s"):format(ns.Professions.DISPLAY[e.prof] or e.prof, e.node.skill, ah)
            elseif e and not NodeHasSafeZone(e.node, ctx.level) then
                how = ("It only grows in zones above your level (%s). %s"):format(table.concat(e.node.zones, ", "), ah)
            else
                how = ah
            end
            local id = "obtain:" .. lname
            d.coveredBy = id
            AddTask(ctx, {
                id = id, kind = "obtain", prof = nil,
                title = ("%s %d x %s"):format(vendor and "Buy" or "Obtain", d.need - have, d.name),
                detail = how .. "\nFor: " .. table.concat(d.reasons, "; "),
                zone = hub, materials = { { name = d.name, itemID = d.itemID, need = d.need, demand = d } },
                confidence = "client", value = 2,
                metric = { materials = true },
                reasons = { "crafting materials" },
            })
        end
    end
end
