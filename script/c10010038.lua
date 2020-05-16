--Recon Operation (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--confirm shield
	aux.AddSpellCastEffect(c,0,nil,aux.ConfirmOperation(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE,0,3))
end
