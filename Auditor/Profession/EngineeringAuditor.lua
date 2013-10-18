EngineeringAuditor = {}
EngineeringAuditor.New = function()
	local self = {}
  
  self.ExtraEnchantAuditor = ExtraEnchantAuditor.New()
  self.EnchantAuditor = EnchantAuditor.New()
  
  self.Audit = function()
    local engineeringLevel = ProfessionInspector.New().GetEngineeringLevel()

    if (engineeringLevel < 380) then
			return
		end    

    self.AuditTinker("BackSlot")      
    self.AuditTinker("WaistSlot")
    
    if (engineeringLevel < 400) then
			return
		end  
    
    self.AuditTinker("HandsSlot")
  end
  
  self.AuditTinker = function(slotName)  
    local itemId = GetInventorySlotInfo(slotName)
    local itemLink = GetInventoryItemLink("player", itemId)
    
    local tinkerName = GetItemSpell(itemLink)

    if(tinkerName == nil) then
      gearWarnings.AddWarning(itemId, "Engineering: missing tinker")      
    end
  end
  
  return self
end