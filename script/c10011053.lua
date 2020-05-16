--Hide and Seek
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return, discard
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return, discard
function scard.retfilter(c)
	return c:IsFaceup() and not c:IsEvolution() and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.retfilter,0,LOCATION_BZONE,1,1,HINTMSG_RTOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and scard.retfilter(tc) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
	Duel.BreakEffect()
	Duel.RandomDiscardHand(1-tp,1,REASON_EFFECT)
end
