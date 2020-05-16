--Invincible Technology
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--search (to hand)
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_SELF,nil,LOCATION_DECK,0,0,MAX_NUMBER,true))
end
