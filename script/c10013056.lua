--龍炎鳳エターナル・フェニックス
--Eternal Phoenix, Phoenix of the Dragonflame
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
	--get ability (attack untapped)
	aux.EnableAttackUntapped(c,nil,nil,LOCATION_BZONE,0,scard.tg1)
	--return
	aux.AddSingleTriggerEffectLeaveBZone(c,0,nil,nil,aux.SendtoHandOperation(nil,aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0))
end
scard.evolution_race_list={RACE_FIRE_BIRD,RACE_ARMORED_DRAGON}
scard.evolution_race_cat_list={RACECAT_DRAGON}
--vortex evolution
scard.evofilter1=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_FIRE_BIRD)
scard.evofilter2=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ARMORED_DRAGON)
--get ability (attack untapped)
function scard.tg1(e,c)
	return c:DMIsRace(RACE_PHOENIX) or c:IsRaceCategory(RACECAT_DRAGON)
end
--return
function scard.thfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsCivilization(CIVILIZATION_FIRE)
end
