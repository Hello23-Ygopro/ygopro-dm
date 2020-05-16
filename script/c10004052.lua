--Mystic Inscription
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,nil,aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1))
end
