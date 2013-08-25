EnchantingAuditor = {}
EnchantingAuditor.New = function()
	local self = {}
  
  self.ExtraEnchantAuditor = ExtraEnchantAuditor.New()
  
  self.RingEnchants400 = Set { 3840, 3839, 3791 }
  self.RingEnchants475 = Set { 4078, 4079, 4080, 4081 }
  self.RingEnchants550 = Set { 4359, 4360, 4361, 4807 }
  
  self.Audit = function()
    if(not ProfessionInspector.New().HasEnchanting()) then
			return
		end
    
    self.ExtraEnchantAuditor.Audit("Finger0Slot", self.RingEnchants550, "Enchanting: Missing enchant")
    self.ExtraEnchantAuditor.Audit("Finger1Slot", self.RingEnchants550, "Enchanting: Missing enchant")
  end
  
  return self
end