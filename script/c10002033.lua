--Poison Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DestroyOperation(PLAYER_SELF,scard.desfilter,LOCATION_BZONE,0,1))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(3000)
end
