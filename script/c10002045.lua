--Barkwhip, the Smasher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	aux.AddEvolutionRaceList(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_BEAST_FOLK))
	--power up
	aux.EnableUpdatePower(c,2000,aux.SelfTappedCondition,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_BEAST_FOLK))
end
