print("whatsup fgats")
GearWarnings = {}
GearWarnings.New = function()
	local self = {}
	
	self.incompleteItems = {}
	
	self.AddMessage = function(itemId, message)
		if (self.incompleteItems[itemId] == nil) then
			self.incompleteItems[itemId] = {}
		end
		
		table.insert(self.incompleteItems[itemId], message)
	end
	
	self.GetMessage = function(itemId)
		text = ""
		for _, message in pairs(self.incompleteItems[itemId]) do
			text = text .. message .. "\n\n"
		end
		return string.sub(text, 0, -2)
	end
	
	self.HasWarnings = function(itemId)
		return #{self.incompleteItems[itemId]} > 0
	end
	
	return self
end

gearWarnings = GearWarnings.New()