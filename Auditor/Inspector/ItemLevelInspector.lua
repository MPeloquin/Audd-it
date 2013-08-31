ItemLevelInspector = {}
ItemLevelInspector.New = function()
	local self = {}
  
  self.GetItemLevel = function(itemName)
    local itemId = GetInventorySlotInfo(itemName)
    local itemLink = GetInventoryItemLink("player", itemId)
   
    local itemLevel = select(4, GetItemInfo(itemLink));
    
    return itemLevel
  end
  
  return self
end