ItemToolTip = {}
ItemToolTip.New = function()
	local self = {}
	
	self.ShowToolTip = function(frame, itemId)
		GameTooltip:SetOwner(frame, "ANCHOR_CURSOR")

		GameTooltip:SetText(gearWarnings.GetMessage(itemId))
		GameTooltip:Show()
	end
	
	self.HideToolTip = function()
		GameTooltip:Hide()	
	end
	
	return self
end