--Überdragon Zaschack
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddEvolutionRaceList(c,RACE_ARMORED_DRAGON)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ARMORED_DRAGON))
	--crew breaker
	aux.EnableCrewBreaker(c,aux.FilterBoolFunction(Card.DMIsRace,RACE_ARMORED_DRAGON))
end
