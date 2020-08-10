--Miraculous Plague
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return, destroy, to grave
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return, destroy, to grave
function scard.filter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.thfilter1(c,e)
	return scard.filter(c,e) and c:IsAbleToHand()
end
function scard.thfilter2(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectMatchingCard(tp,scard.filter,tp,0,LOCATION_BZONE,2,2,nil,e)
	if g1:GetCount()>0 then
		Duel.SetTargetCard(g1)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_RTOHAND)
		local g2=g1:FilterSelect(1-tp,scard.thfilter1,1,1,nil,e)
		Duel.SetTargetCard(g2)
		Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
		g1:Sub(g2)
		Duel.Destroy(g1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g3=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_MZONE,2,2,nil,e)
	if g3:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g3)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_RTOHAND)
		local g4=g3:FilterSelect(1-tp,scard.thfilter2,1,1,nil,e)
		Duel.SetTargetCard(g4)
		Duel.SendtoHand(g4,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(tp,g4)
		g3:Sub(g4)
		Duel.DMSendtoGrave(g3,REASON_EFFECT)
	end
end
