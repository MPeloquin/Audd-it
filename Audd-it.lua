GearAuditor = LibStub("AceAddon-3.0"):NewAddon("GearAuditor", "AceConsole-3.0")

local items=
{
	[1] = { name = "HeadSlot", enchantable = false , align = "TOPRIGHT"},
	[2] = { name = "NeckSlot", enchantable = false , align = "TOPRIGHT"},
	[3] = { name = "ShoulderSlot", enchantable = true , align = "TOPRIGHT"},	
	[5] = { name = "ChestSlot", enchantable = true , align = "TOPRIGHT"},
	[6] = { name = "WaistSlot", enchantable = false , align = "TOPLEFT"},
	[7] = { name = "LegsSlot", enchantable = true , align = "TOPLEFT"},
	[8] = { name = "FeetSlot", enchantable = true , align = "TOPLEFT"},
	[9] = { name = "WristSlot", enchantable = true , align = "TOPRIGHT"},
	[10] = { name = "HandsSlot", enchantable = true , align = "TOPLEFT"},	
	[11] = { name = "Finger0Slot", enchantable = false , align = "TOPLEFT"},
	[12] = { name = "Finger1Slot", enchantable = false , align = "TOPLEFT"},
	[13] = { name = "Trinket0Slot", enchantable = false , align = "TOPLEFT"},
	[14] = { name = "Trinket1Slot", enchantable = false , align = "TOPLEFT"},
	[15] = { name = "BackSlot", enchantable = true , align = "TOPRIGHT"},
	[16] = { name = "MainHandSlot", enchantable = true , align = "TOPLEFT"},
	[17] = { name = "SecondaryHandSlot", enchantable = true , align = "TOPLEFT"},
}

GearWarnings = {}
GearWarnings.New = function()
	local self = {}
	
	self.incompleteItems = {}
	
	self.AddMessage = function(itemId, message)
		if (self.incompleteItems[itemId] == nil) then
			self.incompleteItems[itemId] = {}
		end
		
		table.insert(self.incompleteItems[itemId], message)
	end
	
	self.GetMessage = function(itemId)
		text = ""
		for _, message in pairs(self.incompleteItems[itemId]) do
			text = text .. message .. "\n\n"
		end
		return string.sub(text, 0, -2)
	end
	
	self.HasWarnings = function(itemId)
		return #{self.incompleteItems[itemId]} > 0
	end
	
	return self
end

local gearWarnings = GearWarnings.New()


function GearAuditor:OnEnable()	
	local auditor = Auditor.New()
	local ui = AudditUi.New()
	
	auditor.Audit()

	ui.Show()
end
 

Auditor = {}
Auditor.New = function()
	local self = {}
	
	self.GemAuditor = GemAuditor.New()
	self.EnchantAuditor = EnchantAuditor.New()
	self.ProfessionAuditor = ProfessionAuditor.New()
	self.JewelcraftingAuditor = JewelcraftingAuditor.New()
	
	self.Audit = function()
		for itemId, itemInfo in pairs(items) do
			self.AuditItem(itemInfo.name)
		end
	
		self.AuditCharacter()
	end
	
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
			gearWarnings.AddMessage(itemId, message)
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
			gearWarnings.AddMessage(itemId, "Unenchanted")			
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
		if(not ProfessionsInspector.New().HasJewelCrafting()) then
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

ProfessionsInspector = {}
ProfessionsInspector.New = function()
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

AudditUi = {}
AudditUi.New = function()
	local self = {}
	self.itemFrame = ItemFrame.New()	
	
	self.Show = function()	
		self.ShowItemsWarnings()
	end
	
	self.ShowItemsWarnings = function()
		for itemId, itemInfo in pairs(items) do
			frame = self.itemFrame.Create(itemInfo)

			if ( gearWarnings.HasWarnings(itemId) ) then
				self.itemFrame.ShowFrame(frame, itemId)				
			else
				frame:Hide()
			end
		end	
	end	

	return self
end

ItemFrame = {}
ItemFrame.New = function()
	local self = {}
	self.itemToolTip = ItemToolTip.New()
	
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
		frame:HookScript('OnEnter', function(frame)
			self.itemToolTip.ShowToolTip(frame, itemId)
		end)
		frame:HookScript('OnLeave', function()
			self.itemToolTip.HideToolTip()
		end)
	end	
	return self
end

ItemToolTip = {}
ItemToolTip.New = function()
	local self = {}
	
	self.ShowToolTip = function(frame, itemId)
		GameTooltip:SetOwner(frame, "ANCHOR_CURSOR")

		GameTooltip:SetText(gearWarnings.GetMessage(itemId))
		GameTooltip:Show()
	end
	
	self.HideToolTip = function()
		GameTooltip:Hide()	
	end
	
	return self
end


-- Extract lib
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- Extract lib
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