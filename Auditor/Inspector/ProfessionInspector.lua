ProfessionInspector = {}
ProfessionInspector.New = function()
	local self = {}
	
  self.HasProfession = function(professionId)
    prof1Id, prof2Id = GetProfessions()		
    
		prof1 = select(7, GetProfessionInfo(prof1Id or -1))
		prof2 = select(7, GetProfessionInfo(prof2Id or -1))
    
		if (prof1 == professionId or prof2 == professionId) then
			return true;
		end
		return false;       
  end
  
	self.HasJewelCrafting = function()	
    return self.HasProfession(755)
	end	
  
  self.HasBlackSmithing = function()
    return self.HasProfession(164)
  end  
  
  self.HasLeatherWorking = function()
    return self.HasProfession(165)
  end  
  
  self.HasInscription = function()
    return self.HasProfession(773)
  end  
  
  self.HasTailoring = function()
    return self.HasProfession(197)
  end
	
	return self
end