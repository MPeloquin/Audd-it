BlacksmithingAuditor = {}
BlacksmithingAuditor.New = function()
	local self = {}
  
  self.ExtraGemAuditor = ExtraGemAuditor.New()
  
  self.Audit = function()
    local blacksmithingLevel = ProfessionInspector.New().GetBlackSmithingLevel()
    
    if(blacksmithingLevel == -1) then
			return
		end    
       
    self.ExtraGemAuditor.Audit("WristSlot", "Blacksmithing: Missing socket")
    self.ExtraGemAuditor.Audit("HandsSlot", "Blacksmithing: Missing socket")
  end
  
  return self
end