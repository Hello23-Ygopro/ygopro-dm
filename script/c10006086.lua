--Q-tronic Gargantua
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SURVIVOR))
	--crew breaker
	aux.EnableCrewBreaker(c,aux.FilterBoolFunction(Card.DMIsRace,RACE_SURVIVOR))
end
scard.evolution_race_list={RACE_SURVIVOR}
