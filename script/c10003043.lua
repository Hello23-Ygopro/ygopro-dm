--Überdragon Jabaha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ARMORED_DRAGON))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (power attacker)
	aux.AddStaticEffectPowerAttacker(c,2000,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
end
scard.evolution_race_list={RACE_ARMORED_DRAGON}
scard.evolution_race_cat_list={RACECAT_DRAGON}
