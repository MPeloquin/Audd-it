ProfessionAuditor = {}
ProfessionAuditor.New = function()
	local self = {}
	
  self.JewelcraftingAuditor = JewelcraftingAuditor.New()
  
	self.Audit = function()
      self.JewelcraftingAuditor.Audit()
	end
	
	return self
end