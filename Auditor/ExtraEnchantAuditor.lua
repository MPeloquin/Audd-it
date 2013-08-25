ExtraEnchantAuditor = {}
ExtraEnchantAuditor.New = function()
	local self = {}
  
  self.EnchantAuditor = EnchantAuditor.New()

  self.Audit = function(itemName, enchantsToCompare, message)
    local itemId = GetInventorySlotInfo(itemName)    
    local itemLink = GetInventoryItemLink("player", itemId)
    
    if(itemLink == nil) then
      return
    end
    
    gearWarnings.RemoveEnchantWarning(itemId)

    enchantId = self.EnchantAuditor.GetEnchantId(itemLink)

    if (not enchantsToCompare[enchantId]) then
      gearWarnings.AddWarning(itemId, message)
    end
  end  
	
	return self
end