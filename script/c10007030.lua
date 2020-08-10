--Phantasmal Horror Gigazabal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddEvolutionRaceList(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CHIMERA))
	--stealth (light)
	aux.EnableStealth(c,CIVILIZATION_LIGHT)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
