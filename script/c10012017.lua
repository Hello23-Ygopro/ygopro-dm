--Hydrooze, the Mutant Emperor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_HEDRIAN)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	aux.AddEvolutionRaceList(c,RACE_CYBER_LORD,RACE_HEDRIAN)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CYBER_LORD,RACE_HEDRIAN))
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_CYBER_LORD,RACE_HEDRIAN))
	--get ability (cannot be blocked)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.DMIsRace,RACE_CYBER_LORD,RACE_HEDRIAN))
end
