--Future Slash
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--search (to grave)
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoGraveOperation(PLAYER_SELF,nil,0,LOCATION_DECK,0,2))
end
