--Nexus Charger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoSZoneOperation(PLAYER_SELF,nil,LOCATION_HAND,0,1))
	--charger
	aux.EnableEffectCustom(c,EFFECT_CHARGER)
end
