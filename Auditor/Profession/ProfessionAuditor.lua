ProfessionAuditor = {}
ProfessionAuditor.New = function()
	local self = {}
	
  self.JewelcraftingAuditor = JewelcraftingAuditor.New()
  self.BlacksmithingAuditor = BlacksmithingAuditor.New()
  
	self.Audit = function()
      self.JewelcraftingAuditor.Audit()
      self.BlacksmithingAuditor.Audit()
	end
	
	return self
end