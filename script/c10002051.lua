--Rainbow Stone
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--search (to mana zone)
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(PLAYER_SELF,nil,LOCATION_DECK,0,0,1))
end
