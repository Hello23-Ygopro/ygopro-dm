--Nemonex, Bajula's Robomantis
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_XENOPARTS,RACE_GIANT_INSECT)
	aux.AddEvolutionRaceList(c,RACE_XENOPARTS,RACE_GIANT_INSECT,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_XENOPARTS,RACE_GIANT_INSECT))
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_XENOPARTS,RACE_GIANT_INSECT))
	--to grave
	aux.AddTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to grave
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return aux.UnblockedCondition(e,tp,eg,ep,ev,re,r,rp)
		and tc:IsControler(tp) and tc:DMIsRace(RACE_XENOPARTS,RACE_GIANT_INSECT) and Duel.GetAttackTarget()==nil
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.ManaZoneFilter(Card.DMIsAbleToGrave),0,LOCATION_MZONE,1,1,HINTMSG_TOGRAVE)
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
