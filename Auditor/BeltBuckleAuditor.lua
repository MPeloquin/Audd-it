BeltBuckleAuditor = {}
BeltBuckleAuditor.New = function()
	local self = {}

  self.GemAuditor = GemAuditor.New()

  self.Audit = function()
    local itemId = GetInventorySlotInfo("WaistSlot")
    
    if(GetInventoryItemLink("player", itemId) == nil) then
      return
    end
    
    gemsNumber = self.GemAuditor.CountGems(itemId)
    socketsNumber = self.GemAuditor.CountSockets(itemId)

    gems  = {GetInventoryItemGems(itemId)}

    beltBuckleIndex = socketsNumber + 1
    if(gems[beltBuckleIndex] == nil) then
      gearWarnings.AddWarning(itemId, "Missing Living Steel Belt Buckle")
    else
      gemsNumber = gemsNumber - 1
    end

    self.GemAuditor.AddGemWarning(itemId, gemsNumber, socketsNumber)
  end  

	return self
end