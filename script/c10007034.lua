--Vacuum Gel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsUntapped() and c:IsCivilization(CIVILIZATIONS_LN)
end
