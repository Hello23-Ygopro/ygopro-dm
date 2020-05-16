--Burst Shot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
