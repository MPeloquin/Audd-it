GemAuditor = {}
GemAuditor.New = function()
	local self = {}
	
	self.Audit = function(itemId)
		socketsNumber = self.CountSockets(itemId)
		gemsNumber = self.CountGems(itemId)
		
		emptySockets = socketsNumber - gemsNumber
		if (emptySockets > 0) then
			message = (emptySockets == 1) and "1 empty socket" or emptySockets .. " empty sockets"
			gearWarnings.AddMessage(itemId, message)
		end	
	end	

	self.CountSockets = function(itemId)
		local socketsNumber = 0
		local itemLink = GetInventoryItemLink("player", itemId) or 0
		
		local stats = GetItemStats(itemLink) or {0}
				
		for key,value in pairs(stats) do
			if (string.find(key, "EMPTY")) then
				socketsNumber = socketsNumber + value
			end
		end
				
		return socketsNumber
	end
	
	self.CountGems = function(itemId)
		return #{GetInventoryItemGems(itemId)}		 
	end
	
	return self
end