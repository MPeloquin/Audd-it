JewelcraftingAuditor = {}
JewelcraftingAuditor.New = function()
	local self = {}
	
	self.JcGems = Set { 83151, 136274, 122675, 122676, 122674, 122685, 122684, 136270, 136275, 122683, 122682,136269, 122681, 122680, 122678, 122677, 122679, 136273, 136272 }
	
	self.Audit = function()	
		if(not ProfessionInspector.New().HasJewelCrafting()) then
			return
		end
	
		jcGemsCount = self.CountJcGems();	
		
		if(jcGemsCount < 3) then
			gearWarnings.AddMessage(0, "Jewelcrafting: " .. 3 - jcGemsCount .. " unused Serpent's Eye")
		end
	end	

	self.CountJcGems = function()
		jcGemsCount = 0
		
		for item, itemInfo in pairs(items) do
			gems = {GetInventoryItemGems(item)}
			for key, value in pairs(gems) do
				if (self.JcGems[value]) then
					jcGemsCount = jcGemsCount + 1
				end				
			end			
		end	
		
		return jcGemsCount
	end
	
	return self
end