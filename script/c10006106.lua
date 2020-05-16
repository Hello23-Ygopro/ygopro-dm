--Mystic Treasure Chest
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--search (to mana zone)
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(PLAYER_SELF,scard.tmfilter,LOCATION_DECK,0,0,1))
end
--search (to mana zone)
function scard.tmfilter(c)
	return not c:IsCivilization(CIVILIZATION_NATURE)
end
