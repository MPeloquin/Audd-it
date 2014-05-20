local Auddit = CreateFrame('Frame')
local auditor = Auditor.New()
local ui = AudditUi.New()
gearWarnings = GearWarnings.New()

function Auddit:Execute()	
    gearWarnings.Reset()

    auditor.Audit()  
    
    ui.CreateIfNeeded()
    ui.Show()
end 

Auddit:SetScript('OnEvent', Auddit.Execute)
Auddit:RegisterEvent('PLAYER_LOGIN')
Auddit:RegisterEvent('UNIT_INVENTORY_CHANGED')
--TODO Add event trade completed for enchants via trade