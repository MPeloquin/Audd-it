LeatherworkingAuditor = {}
LeatherworkingAuditor.New = function()
	local self = {}
  
  self.EnchantAuditor = EnchantAuditor.New()
  
  self.LwEnchants400 = Set { 3757, 3758, 4873, 4874 }
  self.LwEnchants500 = Set { 4189, 4190, 4191, 4192 }
  self.LwEnchants575 = Set { 4875, 4877, 4878, 4879 }
  
  self.Audit = function()
    if(not ProfessionInspector.New().HasLeatherWorking()) then
			return
		end
   
    local itemId = GetInventorySlotInfo("WristSlot")    
    local itemLink = GetInventoryItemLink("player", itemId) or -1	
    
    gearWarnings.RemoveEnchantWarning(itemId)

    enchantId = self.EnchantAuditor.GetEnchantId(itemLink)

    if (not self.LwEnchants575[enchantId]) then
      gearWarnings.AddWarning(itemId, "Leatherworking: Missing enchant")
    end
  end
  
  return self
end