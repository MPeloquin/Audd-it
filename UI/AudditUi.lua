AudditUi = {}
AudditUi.New = function()
	local self = {}
	self.ItemFrame = ItemFrame.New()	
	
	self.Show = function()	
		self.ShowItemsFrames()
	end
	
  self.CreateIfNeeded = function()
    if(#frames == 0) then
      
      for id, itemInfo in pairs(items) do
        local createdFrame = self.ItemFrame.Create(itemInfo)
        table.insert(frames, {frame = createdFrame, itemId = id})
      end
      
    end
  end
  
	self.ShowItemsFrames = function()
		for _, frameInfo in pairs(frames) do      
			if ( gearWarnings.HasWarnings(frameInfo.itemId) ) then
				self.ItemFrame.ShowFrame(frameInfo.frame, frameInfo.itemId)				
			else
        self.ItemFrame.HideFrame(frameInfo.frame)
			end      
		end	
	end	

	return self
end