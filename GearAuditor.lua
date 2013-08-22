local items=
{
	[1] = { name = "headSlot", enchantable = false },
	[2] = { name = "neckSlot", enchantable = false },
	[3] = { name = "shoulderSlot", enchantable = true },	
	[5] = { name = "chestSlot", enchantable = true },
	[6] = { name = "waistSlot", enchantable = false },
	[7] = { name = "legsSlot", enchantable = true },
	[8] = { name = "feetSlot", enchantable = true },
	[9] = { name = "wristSlot", enchantable = true },
	[10] = { name = "handsSlot", enchantable = true },	
	[11] = { name = "finger0Slot", enchantable = false },
	[12] = { name = "finger1Slot", enchantable = false },
	[13] = { name = "trinket0Slot", enchantable = false },
	[14] = { name = "trinket1Slot", enchantable = false },
	[15] = { name = "backSlot", enchantable = true },
	[16] = { name = "mainHandSlot", enchantable = true },
	[17] = { name = "secondaryHandSlot", enchantable = true },
}

GearAuditor = LibStub("AceAddon-3.0"):NewAddon("GearAuditor", "AceConsole-3.0")

function GearAuditor:OnEnable()	
	local auditor = Auditor.New()
	local jewelcraftingAuditor = JewelcraftingAuditor.New()
	
	for item, itemInfo in pairs(items) do
		auditor.AuditItem(itemInfo.name)
	end
	
	auditor.AuditCharacter()

	tprint(incompleteItems)
end

Auditor = {}
Auditor.New = function()
	local self = {}
	
	self.GemAuditor = GemAuditor.New()
	self.EnchantAuditor = EnchantAuditor.New()
	self.ProfessionAuditor = ProfessionAuditor.New()
	self.JewelcraftingAuditor = JewelcraftingAuditor.New()
	
	self.AuditItem = function(item)
		local itemId = GetInventorySlotInfo(item)
		
		self.GemAuditor.Audit(itemId)		
		self.EnchantAuditor.Audit(itemId)
		self.ProfessionAuditor.Audit(itemId)
	end
	
	self.AuditCharacter = function()
		self.JewelcraftingAuditor.Audit()
	end
	
	return self
end

GemAuditor = {}
GemAuditor.New = function()
	local self = {}
	
	self.Audit = function(itemId)
		socketsNumber = self.CountSockets(itemId)
		gemsNumber = self.CountGems(itemId)
		
		emptySockets = socketsNumber - gemsNumber
		if (emptySockets > 0) then
			message = (emptySockets == 1) and "1 empty socket" or emptySockets .. " empty sockets"
			AddMessage(itemId, message)
		end	
	end	

	self.CountSockets = function(itemId)
		local socketsNumber = 0
		local itemLink = GetInventoryItemLink("player", itemId) or 0
		
		local stats = GetItemStats(itemLink) or {0}
				
		for key,value in pairs(stats) do
			if (string.find(key, "EMPTY")) then
				socketsNumber = socketsNumber + value
			end
		end
				
		return socketsNumber
	end
	
	self.CountGems = function(itemId)
		return #{GetInventoryItemGems(itemId)}		 
	end
	
	return self
end

EnchantAuditor = {}
EnchantAuditor.New = function()
	local self = {}
	self.Audit = function(itemId)
		if(not items[itemId].enchantable) then
			return
		end
		
		local itemLink = GetInventoryItemLink("player", itemId) or -1		

		if (self.GetEnchantId(itemLink) == 0) then
			AddMessage(itemId, "Unenchanted")			
		end		
	end
	
	self.GetEnchantId = function(itemLink)
		local itemString = select(3 , strsplit("|", itemLink)) or -1
		enchant = select(3 , strsplit(":", itemString)) or -1
		return tonumber(enchant)
	end
	
	return self
end

ProfessionAuditor = {}
ProfessionAuditor.New = function()
	local self = {}
	
	self.Audit = function(itemId)
		
	end
	
	return self
end

JewelcraftingAuditor = {}
JewelcraftingAuditor.New = function()
	local self = {}
	
	self.JcGems = Set { 83151, 136274, 122675, 122676, 122674, 122685, 122684, 136270, 136275, 122683, 122682,136269, 122681, 122680, 122678, 122677, 122679, 136273, 136272 }
	
	self.Audit = function()	
		if(not self.HasJewelCrafting()) then
			return
		end
	
		jcGemsCount = self.CountJcGems();	
		
		if(jcGemsCount < 3) then
			AddMessage(0, "Jewelcrafting: " .. 3 - jcGemsCount .. " unused Serpent's Eye")
		end
	end
	
	-- Extract class
	self.HasJewelCrafting = function()	
		prof1Id, prof2Id = GetProfessions()		
		
		prof1 = select(7, GetProfessionInfo(prof1Id))	
		prof2 = select(7, GetProfessionInfo(prof2Id))
		
		if (prof1 == 755 or prof2 == 755) then
			return true;
		end
		return false;
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

-- Extract class
local incompleteItems = {}
function AddMessage(itemId, message)
	if (incompleteItems[itemId] == nil) then
		incompleteItems[itemId] = {}
	end
	
	table.insert(incompleteItems[itemId], message)
end

-- Extract lib
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- Remove prod || extract lib
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. tostring(v))
    end
  end
end