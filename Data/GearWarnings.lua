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
	
  self.RemoveGemWarning = function(itemId)
    self.RemoveWarningWithMessage(itemId, "socket")
  end  
  
  self.RemoveEnchantWarning = function(itemId)
    self.RemoveWarningWithMessage(itemId, "Unenchanted")
  end

  self.RemoveWarningWithMessage = function(itemId, message)
    if (self.warnings[itemId] == nil) then
      return
    end
    
    for id, message in pairs(self.warnings[itemId]) do
			if (string.find(message, message)) then
        self.warnings[itemId][id] = nil
      end
		end
    
    if (TableSize(self.warnings[itemId]) == 0) then
      self.warnings[itemId] = nil
    end
  end
  
	self.HasWarnings = function(itemId)
		return #{self.warnings[itemId]} > 0
	end	
  
	return self
end

gearWarnings = GearWarnings.New()