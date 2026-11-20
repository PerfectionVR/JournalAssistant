-- Journal Assistant - Shared helpers for the profession planners
-- (ns.ProfPlan): node colours, which gathering node / fish gives an item,
-- guide route band bonuses.

local _, ns = ...
local PP = {}
ns.ProfPlan = PP

PP.NODE_GAIN = { orange = 1.0, yellow = 0.7, green = 0.25 }
PP.VERB = { HERBALISM = "Gather", MINING = "Mine" }

-- Gathering colours (same rule for herbs and ore, confirmed unchanged in Forever)
function PP.NodeColor(skill, req)
    if skill < req then return "red"
    elseif skill < req + 25 then return "orange"
    elseif skill < req + 50 then return "yellow"
    elseif skill < req + 100 then return "green" end
    return "gray"
end

function PP.NodeItems(n) return n.items or { n.name } end

-- item name -> { node, prof } over herbs and ores
local itemIndex
function PP.ItemNode(name)
    if not name then return nil end
    if not itemIndex then
        itemIndex = {}
        for _, h in ipairs(ns.Data.herbs or {}) do itemIndex[string.lower(h.name)] = { node = h, prof = "HERBALISM" } end
        for _, o in ipairs(ns.Data.ores or {}) do
            for _, it in ipairs(o.items) do
                local k = string.lower(it)
                if not itemIndex[k] or itemIndex[k].node.skill > o.skill then itemIndex[k] = { node = o, prof = "MINING" } end
            end
        end
    end
    return itemIndex[string.lower(name)]
end

function PP.HerbInfo(name)
    local e = PP.ItemNode(name)
    return e and e.prof == "HERBALISM" and e.node or nil
end

-- zones where a raw fish is caught
function PP.FishZones(name)
    return name and ns.Data.fish and ns.Data.fish[name]
end

-- bonus for a zone in the guide route band of your skill
function PP.BandBonus(profKey, skill, zone)
    local b = ns.Data.RouteBand and ns.Data.RouteBand(profKey, skill)
    if not b then return 0, nil end
    for i, z in ipairs(b.zones) do
        if z == zone then return (i == 1 and 1.2 or 0.8), b end
    end
    return 0, b
end

function PP.NodeHasSafeZone(node, level)
    for _, z in ipairs(node.zones) do
        if ns.Routes:IsAllowed(z, level) then return true end
    end
    return false
end
