--Death Phoenix, Avatar of Doom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PHOENIX)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter1,scard.evofilter2)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break replace (to grave)
	aux.AddReplaceEffectBreakShield(c,LOCATION_GRAVE)
	--discard
	aux.AddSingleTriggerEffectLeaveBZone(c,0,nil,nil,aux.DiscardOperation(nil,aux.TRUE,0,LOCATION_HAND))
end
scard.evolution_race_list={RACE_ZOMBIE_DRAGON,RACE_FIRE_BIRD}
scard.evolution_race_cat_list={RACECAT_DRAGON}
--vortex evolution
scard.evofilter1=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ZOMBIE_DRAGON)
scard.evofilter2=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_FIRE_BIRD)
