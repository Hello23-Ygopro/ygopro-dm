--Super Terradragon Bailas Gale
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRaceCategory,RACECAT_DRAGON))
	--do not discard shield trigger
	aux.EnablePlayerEffectCustom(c,EFFECT_DONOT_DISCARD_SHIELD_TRIGGER,1,0)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
scard.evolution_race_cat_list={RACECAT_DRAGON}
