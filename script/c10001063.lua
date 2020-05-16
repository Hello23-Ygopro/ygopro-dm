--Terror Pit
--デーモン・ハンド (Demon Hand)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddNameCategory(c,NAMECAT_HAND)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,aux.DestroyOperation(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1))
end
