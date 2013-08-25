ExtraGemAuditor = {}
ExtraGemAuditor.New = function()
	local self = {}
  
  self.GemAuditor = GemAuditor.New()
	
  self.Audit = function(itemName, message)
    local itemId = GetInventorySlotInfo(itemName)

    if(GetInventoryItemLink("player", itemId) == nil) then
      return
    end
  
    gearWarnings.RemoveGemWarning(itemId)  
    
    if (not self.HasExtraGem(itemId)) then
      gearWarnings.AddWarning(itemId, message)
    else
      gemsNumber = gemsNumber - 1
    end    

    self.GemAuditor.AddGemWarning(itemId, gemsNumber, socketsNumber)  
  end
  
  
	self.HasExtraGem = function(itemId)
    gemsNumber = self.GemAuditor.CountGems(itemId)
    socketsNumber = self.GemAuditor.CountSockets(itemId)
    
    gems  = {GetInventoryItemGems(itemId)}
    
    extraGemIndex = socketsNumber + 1
    
    if(gems[extraGemIndex] == nil) then
      return false
    end    
    return true
	end
	
	return self
end