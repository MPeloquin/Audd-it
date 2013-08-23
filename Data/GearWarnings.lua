GearWarnings = {}
GearWarnings.New = function()
	local self = {}
	
	self.warnings = {}
	
	self.AddWarning = function(itemId, message)
		if (self.warnings[itemId] == nil) then
			self.warnings[itemId] = {}
		end
		
		table.insert(self.warnings[itemId], message)
	end
	
	self.GetWarning = function(itemId)
		text = ""
		for _, message in pairs(self.warnings[itemId]) do
			text = text .. message .. "\n\n"
		end
		return string.sub(text, 0, -2)
	end
	
	self.HasWarnings = function(itemId)
		return #{self.warnings[itemId]} > 0
	end
	
	return self
end

gearWarnings = GearWarnings.New()