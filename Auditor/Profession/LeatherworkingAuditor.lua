LeatherworkingAuditor = {}
LeatherworkingAuditor.New = function()
	local self = {}
  
  self.ExtraEnchantAuditor = ExtraEnchantAuditor.New()
  
  self.LwEnchants400 = Set { 3757, 3758, 4873, 4874 }
  self.LwEnchants500 = Set { 4189, 4190, 4191, 4192 }
  self.LwEnchants575 = Set { 4875, 4877, 4878, 4879 }
  
  self.Audit = function()
    local leatherWorkingLevel = ProfessionInspector.New().GetLeatherWorkingLevel()    
    
    if(leatherWorkingLevel == -1) then
			return
		end
    
    self.ExtraEnchantAuditor.Audit("WristSlot", self.LwEnchants575, "Leatherworking: Missing enchant")
  end
  
  return self
end