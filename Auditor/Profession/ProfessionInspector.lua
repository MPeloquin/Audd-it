ProfessionInspector = {}
ProfessionInspector.New = function()
	local self = {}
		
	self.HasJewelCrafting = function()	
		prof1Id, prof2Id = GetProfessions()		
		
		prof1 = select(7, GetProfessionInfo(prof1Id))	
		prof2 = select(7, GetProfessionInfo(prof2Id))
		
		if (prof1 == 755 or prof2 == 755) then
			return true;
		end
		return false;
	end	
	
	return self
end