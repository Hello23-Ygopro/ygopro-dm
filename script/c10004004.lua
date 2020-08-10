--Doboulgyser, Giant Rock Beast
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	aux.AddEvolutionRaceList(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ROCK_BEAST))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(3000)
end
scard.tg1=aux.CheckCardFunction(scard.desfilter,0,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1)
