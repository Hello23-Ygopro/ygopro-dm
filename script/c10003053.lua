--Roar of the Earth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(scard.thfilter),LOCATION_MZONE,0,1))
end
--return
function scard.thfilter(c)
	return c:IsCreature() and c:IsManaCostAbove(6)
end
