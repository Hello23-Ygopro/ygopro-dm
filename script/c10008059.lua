--Überdragon Bajula
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRaceCategory,RACECAT_DRAGON))
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
end
scard.evolution_race_cat_list={RACECAT_DRAGON}
--to grave
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ManaZoneFilter(Card.DMIsAbleToGrave),0,LOCATION_MZONE,0,2,HINTMSG_TOGRAVE)
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
