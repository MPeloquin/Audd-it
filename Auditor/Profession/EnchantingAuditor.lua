EnchantingAuditor = {}
EnchantingAuditor.New = function()
	local self = {}
  
  self.ExtraEnchantAuditor = ExtraEnchantAuditor.New()
  
  self.RingEnchants400 = Set { 3840, 3839, 3791 }
  self.RingEnchants475 = Set { 4078, 4079, 4080, 4081 }
  self.RingEnchants550 = Set { 4359, 4360, 4361, 4807 }
  
  self.Audit = function()
    local enchantingLevel = ProfessionInspector.New().GetEnchantingLevel()
    
    if (enchantingLevel == -1) then
			return
		end
    
    local tableToUse = {}
    if (enchantingLevel >= 400 and enchantingLevel < 475) then
      tableToUse = self.RingEnchants400
    elseif (enchantingLevel < 550) then
      tableToUse = self.RingEnchants475
    else
      tableToUse = self.RingEnchants550
    end
    
    
    self.ExtraEnchantAuditor.Audit("Finger0Slot", tableToUse, "Enchanting: Missing enchant")
    self.ExtraEnchantAuditor.Audit("Finger1Slot", tableToUse, "Enchanting: Missing enchant")
  end
  
  return self
end