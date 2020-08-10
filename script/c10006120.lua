--Ultra Mantis, Scourge of Fate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	aux.AddEvolutionRaceList(c,RACE_GIANT_INSECT,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GIANT_INSECT))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedBoolFunction(Card.IsPowerBelow,8000))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
