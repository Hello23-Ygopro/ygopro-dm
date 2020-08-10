--Ballom, Master of Death
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	aux.AddNameCategory(c,NAMECAT_BALLOM)
	aux.AddEvolutionRaceList(c,RACE_DEMON_COMMAND)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DEMON_COMMAND))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and not c:IsCivilization(CIVILIZATION_DARKNESS)
end
