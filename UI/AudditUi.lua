AudditUi = {}
AudditUi.New = function()
	local self = {}
	self.ItemFrame = ItemFrame.New()	
	
	self.Show = function()	
		self.ShowItemsWarnings()
	end
	
	self.ShowItemsWarnings = function()
		for itemId, itemInfo in pairs(items) do
			frame = self.ItemFrame.Create(itemInfo)

			if ( gearWarnings.HasWarnings(itemId) ) then
				self.ItemFrame.ShowFrame(frame, itemId)				
			else
				frame:Hide()
			end
		end	
	end	

	return self
end