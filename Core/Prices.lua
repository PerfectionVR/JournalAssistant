-- Journal Assistant - Price estimates
--
-- Uses Auctionator's public API when it is loaded (checked against the
-- installed Auctionator source, Source/API/v1/*.lua):
--   Auctionator.API.v1.GetAuctionPriceByItemID(callerID, itemID) -> copper | nil
--   Auctionator.API.v1.GetAuctionAgeByItemID(callerID, itemID)   -> days since seen (nil if > 21 days / never)
--   Auctionator.API.v1.GetVendorPriceByItemID(callerID, itemID)  -> vendor buy price cached by Auctionator | nil
--   Auctionator.API.v1.RegisterForDBUpdate(callerID, callback)   -> called after AH scans
-- Without Auctionator (or without a price for an item) no number is invented:
-- the task says "no price data".

local ADDON, ns = ...
local PR = {}
ns.Prices = PR

local CALLER = "JournalAssistant"

local function api()
    local a = _G.Auctionator
    return a and a.API and a.API.v1
end

function PR:Available()
    local v1 = api()
    return v1 and type(v1.GetAuctionPriceByItemID) == "function" and true or false
end

-- returns copper, source ("vendor" | "ah"), ageDays  (or nil)
function PR:Get(itemID)
    itemID = tonumber(itemID)
    local v1 = api()
    if not itemID or not v1 then return nil end
    local vendor, ah, age
    if type(v1.GetVendorPriceByItemID) == "function" then
        local ok, p = pcall(v1.GetVendorPriceByItemID, CALLER, itemID)
        if ok and type(p) == "number" and p > 0 then vendor = p end
    end
    if type(v1.GetAuctionPriceByItemID) == "function" then
        local ok, p = pcall(v1.GetAuctionPriceByItemID, CALLER, itemID)
        if ok and type(p) == "number" and p > 0 then ah = p end
    end
    if type(v1.GetAuctionAgeByItemID) == "function" then
        local ok, a = pcall(v1.GetAuctionAgeByItemID, CALLER, itemID)
        if ok and type(a) == "number" then age = a end
    end
    if vendor and (not ah or vendor <= ah) then return vendor, "vendor" end
    if ah then return ah, "ah", age end
    return nil
end

-- itemID for an item name we only know by name (learned from bags / scans)
function PR:IDFor(item)
    return item.itemID or (item.name and ns.Inventory:IDForName(item.name))
end

function PR:Format(copper)
    if not copper then return "?" end
    copper = math.floor(copper + 0.5)
    local g, s, c = math.floor(copper / 10000), math.floor(copper / 100) % 100, copper % 100
    local parts = {}
    if g > 0 then parts[#parts + 1] = g .. "g" end
    if s > 0 then parts[#parts + 1] = s .. "s" end
    if c > 0 or #parts == 0 then parts[#parts + 1] = c .. "c" end
    return table.concat(parts, " ")
end

-- Annotate a task: t.cost (copper for everything still missing), t.costLines
-- (per item, for the tooltip) and t.costMissing (items without price data).
function PR:Annotate(t)
    local entries = {}
    for _, m in ipairs(t.materials or {}) do
        local have = m.have or ns.Inventory:Count(m)
        local missing = math.max(0, (m.need or 0) - have)
        if missing > 0 then entries[#entries + 1] = { name = m.name, itemID = self:IDFor(m), qty = missing } end
    end
    if t.buyItem and not (t.materials and #t.materials > 0) then
        local b = t.buyItem
        if ns.Inventory:Count(b) < (b.qty or 1) then
            entries[#entries + 1] = { name = b.name, itemID = self:IDFor(b), qty = b.qty or 1 }
        end
    end
    if #entries == 0 then return end
    local total, lines, missingData = 0, {}, {}
    for _, e in ipairs(entries) do
        local p, src, age = self:Get(e.itemID)
        if p then
            total = total + p * e.qty
            lines[#lines + 1] = ("%s: %d x %s (%s%s) = %s"):format(e.name or ("item " .. tostring(e.itemID)), e.qty, self:Format(p),
                src == "vendor" and "vendor" or "AH",
                (src == "ah" and age) and (", seen " .. (age == 0 and "today" or (age .. "d ago"))) or (src == "ah" and ", price 21+ days old" or ""),
                self:Format(p * e.qty))
        else
            missingData[#missingData + 1] = e.name or ("item " .. tostring(e.itemID))
        end
    end
    t.cost = total > 0 and total or nil
    t.costLines = lines
    t.costMissing = missingData
end

function PR:Init()
    local v1 = api()
    if v1 and type(v1.RegisterForDBUpdate) == "function" then
        pcall(v1.RegisterForDBUpdate, CALLER, function() ns:RequestRefresh("prices") end)
    end
end
