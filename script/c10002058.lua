--Ultracide Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PARASITE_WORM)
	aux.AddEvolutionRaceList(c,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_PARASITE_WORM))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
