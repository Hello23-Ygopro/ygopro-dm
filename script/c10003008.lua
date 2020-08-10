--Sieg Balicula, the Intense
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	aux.AddEvolutionRaceList(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_INITIATE))
	--get ability (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_LIGHT))
end
