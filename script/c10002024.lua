--Chaos Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PARASITE_WORM)
	aux.AddEvolutionRaceList(c,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_PARASITE_WORM))
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--destroy
scard.tg1=aux.CheckCardFunction(Card.IsFaceup,0,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1)
