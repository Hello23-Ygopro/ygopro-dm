--Cloned Spiral
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,1,1,nil)
	local ct=Duel.GetMatchingGroupCount(aux.DMGraveFilter(Card.IsCode),tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,sid)
	if g:GetCount()==0 or ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,0,ct,g)
end
scard.op1=aux.TargetSendtoHandOperation()
