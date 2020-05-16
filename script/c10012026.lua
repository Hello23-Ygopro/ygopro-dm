--Cloned Nightmare
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--discard
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--discard
function scard.dhfilter(c,e)
	return c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(scard.dhfilter,tp,0,LOCATION_HAND,nil,e)
	local sg1=g:RandomSelect(tp,1)
	Duel.SetTargetCard(sg1)
	g:Sub(sg1)
	local ct=Duel.GetMatchingGroupCount(aux.DMGraveFilter(Card.IsCode),tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,sid)
	if g:GetCount()==0 or ct==0 then return end
	local sg2=g:RandomSelect(tp,0,ct)
	Duel.SetTargetCard(sg2)
end
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT+REASON_DISCARD)
