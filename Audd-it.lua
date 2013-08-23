local Auddit = CreateFrame('Frame')

function Auddit:Execute()	
	gearWarnings = GearWarnings.New()
	
	local auditor = Auditor.New()
	local ui = AudditUi.New()
  
	auditor.Audit()
  
  
  ui.CreateIfNeeded()
	ui.Show()
end 

Auddit:SetScript('OnEvent', Auddit.Execute)
Auddit:RegisterEvent('PLAYER_ENTERING_WORLD')
Auddit:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')