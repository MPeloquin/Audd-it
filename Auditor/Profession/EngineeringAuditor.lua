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

    self.AuditTinker(GetInventorySlotInfo("BackSlot"))      
    self.AuditTinker(GetInventorySlotInfo("WaistSlot"))
    
    if (engineeringLevel < 400) then
			return
		end  
    
    self.AuditTinker(GetInventorySlotInfo("HandsSlot"))
  end
  
  self.AuditTinker = function(itemId)    
    local itemLink = GetInventoryItemLink("player", itemId)
    
    local tinkerName = GetItemSpell(itemLink)

    if(tinkerName == nil) then
      gearWarnings.AddWarning(itemId, "Engineering: missing tinker")      
    end
  end
  
  return self
end