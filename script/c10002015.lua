--Crystal Lancer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	aux.AddEvolutionRaceList(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_LIQUID_PEOPLE))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
