--Screaming Sunburst
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--tap
	aux.AddSpellCastEffect(c,0,nil,aux.TapOperation(nil,scard.posfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and not c:IsCivilization(CIVILIZATION_LIGHT)
end
