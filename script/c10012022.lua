--Cloned Deflector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--tap
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g=Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,1,1,nil)
	local ct=Duel.GetMatchingGroupCount(aux.DMGraveFilter(Card.IsCode),tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,sid)
	if g:GetCount()==0 or ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,0,ct,g)
end
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
