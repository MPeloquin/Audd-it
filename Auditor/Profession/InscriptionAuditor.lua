InscriptionAuditor = {}
InscriptionAuditor.New = function()
	local self = {}
  
  self.EnchantAuditor = EnchantAuditor.New()
  
  self.InscriptionEnchants = Set { 4912, 4913, 4914, 4915 }
  
  self.Audit = function()
    if(not ProfessionInspector.New().HasInscription()) then
			return
		end
   
    local itemId = GetInventorySlotInfo("ShoulderSlot")    
    local itemLink = GetInventoryItemLink("player", itemId) or -1	
    
    gearWarnings.RemoveEnchantWarning(itemId)

    enchantId = self.EnchantAuditor.GetEnchantId(itemLink)

    if (not self.InscriptionEnchants[enchantId]) then
      gearWarnings.AddWarning(itemId, "Inscription: Missing enchant")
    end
  end
  
  return self
end