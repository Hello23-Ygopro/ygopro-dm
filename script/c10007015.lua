--Rondobil, the Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (to shield zone)
	aux.EnableTapAbility(c,0,nil,aux.SendtoSZoneOperation(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1))
end
