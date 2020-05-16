--Blizzard of Spears
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(4000)
end
