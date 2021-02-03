--Reap and Sow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to grave, to mana zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave, to mana zone
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ManaZoneFilter(Card.DMIsAbleToGrave),0,LOCATION_MZONE,1,1,HINTMSG_TOGRAVE)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.DMSendtoGrave(tc,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.SendDecktoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
