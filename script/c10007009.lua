--Kizar Basiku, the Outrageous
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	aux.AddEvolutionRaceList(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_INITIATE))
	--stealth (fire)
	aux.EnableStealth(c,CIVILIZATION_FIRE)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
