--Hopeless Vortex
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,aux.DestroyOperation(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1))
end
