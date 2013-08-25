ProfessionInspector = {}
ProfessionInspector.New = function()
	local self = {}
	
  self.GetProfessionLevel = function(professionId)
    prof1Id, prof2Id = GetProfessions()		
    
    _,_,prof1level, _, _, _, prof1 = GetProfessionInfo(prof1Id or -1)
    _,_,prof2level, _, _, _, prof2 = GetProfessionInfo(prof2Id or -1)

    if (prof1 == professionId) then
			return prof1level
    elseif (prof2 == professionId) then
      return prof2level
		end
		return -1;
  end
  
	self.GetJewelCraftingLevel = function()	
    return self.GetProfessionLevel(755)
	end	
  
  self.GetBlackSmithingLevel = function()
    return self.GetProfessionLevel(164)
  end  
  
  self.GetLeatherWorkingLevel = function()
    return self.GetProfessionLevel(165)
  end  
  
  self.GetInscriptionLevel = function()
    return self.GetProfessionLevel(773)
  end  
  
  self.GetTailoringLevel = function()
    return self.GetProfessionLevel(197)
  end  
  
  self.GetEnchantingLevel = function()
    return self.GetProfessionLevel(333)
  end 
	
	return self
end