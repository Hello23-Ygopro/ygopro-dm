--Aura Pegasus, Avatar of Life
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PEGASUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter1,scard.evofilter2)
	--confirm deck (to battle zone or to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
	aux.AddSingleTriggerEffectLeaveBZone(c,0,nil,nil,scard.op1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
end
scard.evolution_race_list={RACE_HORNED_BEAST,RACE_ANGEL_COMMAND}
scard.evolution_race_cat_list={RACECAT_COMMAND}
--vortex evolution
scard.evofilter1=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_HORNED_BEAST)
scard.evofilter2=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ANGEL_COMMAND)
--confirm deck (to battle zone or to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsCreature() and not tc:IsEvolution() and tc:IsAbleToBZone(e,0,tp,false,false) then
		Duel.SendtoBZone(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	else
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end
