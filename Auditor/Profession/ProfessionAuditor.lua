ProfessionAuditor = {}
ProfessionAuditor.New = function()
	local self = {}
	
  self.JewelcraftingAuditor = JewelcraftingAuditor.New()
  self.BlacksmithingAuditor = BlacksmithingAuditor.New()
  self.LeatherworkingAuditor = LeatherworkingAuditor.New()
  
	self.Audit = function()
      self.JewelcraftingAuditor.Audit()
      self.BlacksmithingAuditor.Audit()
      self.LeatherworkingAuditor.Audit()
	end
	
	return self
end