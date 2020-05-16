--Divine Riptide
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(nil,aux.ManaZoneFilter(),LOCATION_MZONE,LOCATION_MZONE))
end
