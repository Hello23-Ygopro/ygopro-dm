--Bombersaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	Duel.SelectTarget(tp,aux.ManaZoneFilter(Card.DMIsAbleToGrave),tp,LOCATION_MZONE,0,2,2,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	Duel.SelectTarget(1-tp,aux.ManaZoneFilter(Card.DMIsAbleToGrave),1-tp,LOCATION_MZONE,0,2,2,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
