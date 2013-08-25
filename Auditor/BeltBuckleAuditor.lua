BeltBuckleAuditor = {}
BeltBuckleAuditor.New = function()
	local self = {}

  self.ExtraGemAuditor = ExtraGemAuditor.New()

  self.Audit = function()
    self.ExtraGemAuditor.Audit("WaistSlot", "Missing Living Steel Belt Buckle")
  end   

	return self
end