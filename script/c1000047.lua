--Dyno Mantis, the Mightspinner
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	aux.AddEvolutionRaceList(c,RACE_GIANT_INSECT,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GIANT_INSECT))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (break extra shield)
	aux.EnableEffectCustom(c,EFFECT_BREAK_EXTRA_SHIELD,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsPowerAbove,5000))
end
