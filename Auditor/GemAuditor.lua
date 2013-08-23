GemAuditor = {}
GemAuditor.New = function()
	local self = {}
	
	self.Audit = function(itemId)
		socketsNumber = self.CountSockets(itemId)
		gemsNumber = self.CountGems(itemId)
		
    self.AddGemWarning(itemId, gemsNumber, socketsNumber)
	end	

	self.CountSockets = function(itemId)
		local socketsNumber = 0
		local itemLink = GetInventoryItemLink("player", itemId) or 0
		
		local stats = GetItemStats(itemLink) or {0}
				
		for info, number in pairs(stats) do
			if (string.find(info, "EMPTY")) then
				socketsNumber = socketsNumber + number
			end
		end
				
		return socketsNumber
	end
	
	self.CountGems = function(itemId)
    return TableSize({GetInventoryItemGems(itemId)})
	end
  
  self.AddGemWarning = function(itemId, gemsNumber, socketsNumber)
    emptySockets = socketsNumber - gemsNumber
    
		if (emptySockets > 0) then
			message = (emptySockets == 1) and "1 empty socket" or emptySockets .. " empty sockets"
			gearWarnings.AddWarning(itemId, message)
		end	
  end
	
	return self
end