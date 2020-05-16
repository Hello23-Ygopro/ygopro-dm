--Lost Soul
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--discard
	aux.AddSpellCastEffect(c,0,nil,aux.DiscardOperation(nil,aux.TRUE,0,LOCATION_HAND))
end
