TailoringAuditor = {}
TailoringAuditor.New = function()
	local self = {}
  
  self.ExtraEnchantAuditor = ExtraEnchantAuditor.New()
  
  self.TailoringEnchants = Set { 3730, 3728, 3722 }
  self.TailoringEnchants = Set { 4118, 4116, 4115 }
  self.TailoringEnchants = Set { 4892, 4893, 4894 }
  
  self.Audit = function()
    if(not ProfessionInspector.New().HasTailoring()) then
			return
		end
    
    self.ExtraEnchantAuditor.Audit("BackSlot", self.TailoringEnchants, "Tailoring: Missing enchant")
  end
  
  return self
end