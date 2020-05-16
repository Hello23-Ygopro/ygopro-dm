--Liquid Scope
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--confirm hand, shield
	aux.AddSpellCastEffect(c,0,nil,aux.ConfirmOperation(PLAYER_SELF,scard.conffilter,0,LOCATION_HAND+LOCATION_SZONE))
end
--confirm hand, shield
function scard.conffilter(c)
	return (c:IsShield() and c:IsFacedown()) or (c:IsLocation(LOCATION_HAND) and not c:IsPublic())
end
