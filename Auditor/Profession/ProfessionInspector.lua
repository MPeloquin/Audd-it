ProfessionInspector = {}
ProfessionInspector.New = function()
	local self = {}
	
  self.HasProfession = function(professionId)
    prof1Id, prof2Id = GetProfessions()		
		
    
		prof1 = select(7, GetProfessionInfo(prof1Id or -1))	or -1
		prof2 = select(7, GetProfessionInfo(prof2Id or -1)) or -1
		
		if (prof1 == professionId or prof2 == professionId) then
			return true;
		end
		return false;       
  end
  
	self.HasJewelCrafting = function()	
    self.HasProfession(755)
	end	
	
	return self
end