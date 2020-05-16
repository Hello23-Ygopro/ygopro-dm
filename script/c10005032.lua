--Skullsweeper Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (discard)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddSingleGrantTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,LOCATION_ALL,0,scard.tg2)
end
--survivor (discard)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	Duel.SelectTarget(1-tp,aux.TRUE,1-tp,LOCATION_HAND,0,1,1,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT+REASON_DISCARD)
scard.tg2=aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR)
