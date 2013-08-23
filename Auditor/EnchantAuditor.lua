EnchantAuditor = {}
EnchantAuditor.New = function()
	local self = {}
	self.Audit = function(itemId)
		if(not items[itemId].enchantable) then
			return
		end
		
		local itemLink = GetInventoryItemLink("player", itemId) or -1		

		if (self.GetEnchantId(itemLink) == 0) then
			gearWarnings.AddMessage(itemId, "Unenchanted")			
		end		
	end
	
	self.GetEnchantId = function(itemLink)
		local itemString = select(3 , strsplit("|", itemLink)) or -1
		enchant = select(3 , strsplit(":", itemString)) or -1
		return tonumber(enchant)
	end
	
	return self
end