frames = {}

ItemFrame = {}
ItemFrame.New = function()
	local self = {}
	self.ItemToolTip = ItemToolTip.New()
	
	self.Create = function(itemInfo)
		var = _G["Character" .. itemInfo.name]
		local frame = CreateFrame("Frame",nil, var)
		frame:EnableMouse(true)
		frame:SetWidth(15)
		frame:SetHeight(15)
		frame:SetPoint(itemInfo.align, (itemInfo.align == "TOPLEFT") and -10 or 10 ,7)

		local texture = frame:CreateTexture(nil,"FOREGROUND")
		texture:SetTexture("Interface\\AddOns\\Audd-it\\Textures\\warning.tga")
		texture:SetAllPoints(frame)
		frame.texture = texture
		
		return frame
	end
	
	self.ShowFrame = function(frame, itemId)
		frame:Show()
		frame:SetScript('OnEnter', function(frame)
			self.ItemToolTip.ShowToolTip(frame, itemId)
		end)
		frame:SetScript('OnLeave', function()
			self.ItemToolTip.HideToolTip()
		end)
	end	
  
  self.HideFrame = function(frame)
    frame:Hide()
  end
  
	return self
end