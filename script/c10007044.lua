--Valkrowzer, Ultra Rock Beast
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	aux.AddEvolutionRaceList(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ROCK_BEAST))
	--stealth (water)
	aux.EnableStealth(c,CIVILIZATION_WATER)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
