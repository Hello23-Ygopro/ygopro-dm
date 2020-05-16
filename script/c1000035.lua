--Brigade Shell Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (confirm deck - to hand or to grave)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.HintTarget,scard.op1)
	aux.AddSingleGrantTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.HintTarget,scard.op1,nil,LOCATION_ALL,0,scard.tg1)
end
--survivor (confirm deck - to hand or to grave)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.DisableShuffleCheck()
	if tc:DMIsRace(RACE_SURVIVOR) and tc:IsAbleToHand() then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	else
		Duel.DMSendtoGrave(tc,REASON_EFFECT)
	end
end
scard.tg1=aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR)
