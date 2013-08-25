JewelcraftingAuditor = {}
JewelcraftingAuditor.New = function()
	local self = {}
	
	self.JcGems = Set { 83151, 136274, 122675, 122676, 122674, 122685, 122684, 136270, 136275, 122683, 122682,136269, 122681, 122680, 122678, 122677, 122679, 136273, 136272 }
	
	self.Audit = function()	
    local jewelCraftingLevel = ProfessionInspector.New().GetJewelCraftingLevel()
    
		if(jewelCraftingLevel == -1) then
			return
		end
	
		jcGemsCount = self.CountJcGems();	
		
		if(jcGemsCount < 2) then
			gearWarnings.AddWarning(0, "Jewelcrafting: " .. 2 - jcGemsCount .. " unused Serpent's Eye")
		end
	end	

	self.CountJcGems = function()
		jcGemsCount = 0
		
		for item, itemInfo in pairs(items) do
			gems = {GetInventoryItemGems(item)}
			for key, gemId in pairs(gems) do
				if (self.JcGems[gemId]) then
					jcGemsCount = jcGemsCount + 1
				end				
			end			
		end	
		
		return jcGemsCount
	end
	
	return self
end