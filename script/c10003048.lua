--Mana Nexus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoSZoneOperation(PLAYER_SELF,aux.ManaZoneFilter(),LOCATION_MZONE,0,1))
end
