--Phantomach, the Gigatrooper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CHIMERA,RACE_ARMORLOID))
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_CHIMERA,RACE_ARMORLOID))
	--get ability (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.DMIsRace,RACE_CHIMERA,RACE_ARMORLOID))
end
scard.evolution_race_list={RACE_CHIMERA,RACE_ARMORLOID}
