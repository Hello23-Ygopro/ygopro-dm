--Super Necrodragon Abzo Dolba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRaceCategory,RACECAT_DRAGON))
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
end
scard.evolution_race_cat_list={RACECAT_DRAGON}
--power up
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.DMGraveFilter(Card.IsCreature),c:GetControler(),LOCATION_GRAVE,0,nil)*2000
end
