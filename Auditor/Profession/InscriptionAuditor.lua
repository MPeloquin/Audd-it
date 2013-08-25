InscriptionAuditor = {}
InscriptionAuditor.New = function()
	local self = {}
  
  self.ExtraEnchantAuditor = ExtraEnchantAuditor.New()
  
  self.InscriptionEnchants = Set { 4912, 4913, 4914, 4915 }
  
  self.Audit = function()
    if(not ProfessionInspector.New().HasInscription()) then
			return
		end
    
    self.ExtraEnchantAuditor.Audit("ShoulderSlot", self.InscriptionEnchants, "Inscription: Missing enchant")
  end
  
  return self
end