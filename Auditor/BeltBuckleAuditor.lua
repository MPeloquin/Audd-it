BeltBuckleAuditor = {}
BeltBuckleAuditor.New = function()
	local self = {}

  self.ExtraGemAuditor = ExtraGemAuditor.New()
  
  self.Audit = function()    
    local itemLevel = ItemLevelInspector.New().GetItemLevel("WaistSlot") or 0
    local playerLevel = UnitLevel("player") or 0
    
    if (itemLevel >= 417 and playerLevel >= 85) then
      self.ExtraGemAuditor.Audit("WaistSlot", "Missing Living Steel Belt Buckle")
    elseif (itemLevel >= 300 and playerLevel >= 80) then
      self.ExtraGemAuditor.Audit("WaistSlot", "Missing Ebonsteel Belt Buckle")
    elseif (playerLevel >= 70) then
      self.ExtraGemAuditor.Audit("WaistSlot", "Missing Eternal Belt Buckle")
    end
  end   

	return self
end