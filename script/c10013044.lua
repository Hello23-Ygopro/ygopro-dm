--ナイトメア・マシーン
--Nightmare Machine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--destroy
function scard.desfilter1(c)
	return c:IsFaceup() and c:IsUntapped()
end
function scard.desfilter2(c,e)
	return scard.desfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,scard.desfilter1,tp,LOCATION_BZONE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.Destroy(g1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
	local g2=Duel.SelectMatchingCard(1-tp,scard.desfilter2,1-tp,LOCATION_BZONE,0,1,1,nil,e)
	if g2:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g2)
		Duel.Destroy(g2,REASON_EFFECT)
	end
end
