--Hurlosaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(1000)
end
