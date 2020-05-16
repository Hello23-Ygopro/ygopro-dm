--Shock Hurricane
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.retfilter1(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function scard.retfilter2(c,e)
	return scard.retfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(scard.retfilter1,tp,LOCATION_BZONE,0,nil)
	local ct2=0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,scard.retfilter1,tp,LOCATION_BZONE,0,0,ct1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		ct2=Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(scard.retfilter2,tp,0,LOCATION_BZONE,nil,e)
	if ct2>g2:GetCount() or g2:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_TOHAND) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g2:Select(tp,ct2,ct2,nil)
	if sg:GetCount()==0 then return end
	Duel.SetTargetCard(sg)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
end
