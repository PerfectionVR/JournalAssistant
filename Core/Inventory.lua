-- Journal Assistant - Inventory counts
--
-- Counts items by itemID when known (C_Item.GetItemCount, optionally incl. bank)
-- or by name from a bag scan. Item IDs are learned at runtime from your bags and
-- recipe reagent scans and stored account-wide by lower-case name; nothing is
-- hard-coded.

local _, ns = ...
local I = {}
ns.Inventory = I

local bagByName = {}
local dirty = true

local function NumSlots(bag)
    if C_Container and C_Container.GetContainerNumSlots then
        return C_Container.GetContainerNumSlots(bag) or 0
    elseif GetContainerNumSlots then
        return GetContainerNumSlots(bag) or 0
    end
    return 0
end

local function SlotInfo(bag, slot)
    if C_Container and C_Container.GetContainerItemInfo then
        local info = C_Container.GetContainerItemInfo(bag, slot)
        if info then return info.itemID, info.stackCount or 1, info.itemName end
    elseif GetContainerItemInfo then
        local _, count, _, _, _, _, _, _, _, id = GetContainerItemInfo(bag, slot)
        return id, count or 1, nil
    end
end

function I.ItemName(itemID)
    if not itemID then return nil end
    if C_Item and C_Item.GetItemNameByID then
        local n = C_Item.GetItemNameByID(itemID)
        if n then return n end
    end
    if GetItemInfo then
        local n = GetItemInfo(itemID)
        if n then return n end
    end
    if C_Item and C_Item.RequestLoadItemDataByID then pcall(C_Item.RequestLoadItemDataByID, itemID) end
    return nil
end

function I:LearnID(name, itemID)
    if name and itemID and ns.db then
        ns.db.itemIDs[string.lower(name)] = itemID
    end
end

function I:IDForName(name)
    return name and ns.db and ns.db.itemIDs[string.lower(name)]
end

function I:MarkDirty() dirty = true end

function I:ScanBags()
    wipe(bagByName)
    local last = NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS or 4
    for bag = 0, last do
        for slot = 1, NumSlots(bag) do
            local id, count, name = SlotInfo(bag, slot)
            if id then
                name = name or I.ItemName(id)
                if name then
                    local lname = string.lower(name)
                    bagByName[lname] = (bagByName[lname] or 0) + count
                    I:LearnID(name, id)
                end
            end
        end
    end
    dirty = false
end

-- Count an item. `item` = { itemID = n?, name = "..."? }
function I:Count(item)
    if dirty then self:ScanBags() end
    local id = item.itemID or self:IDForName(item.name)
    if id then
        local includeBank = ns.db and ns.db.includeBank
        if C_Item and C_Item.GetItemCount then
            local ok, n = pcall(C_Item.GetItemCount, id, includeBank)
            if ok and n then return n end
        elseif GetItemCount then
            local ok, n = pcall(GetItemCount, id, includeBank)
            if ok and n then return n end
        end
    end
    if item.name then return bagByName[string.lower(item.name)] or 0 end
    return 0
end

function I:CountName(name) return self:Count({ name = name }) end
