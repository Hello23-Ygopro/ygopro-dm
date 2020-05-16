--Aurora of Reversal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to mana zone
function scard.tmfilter(c,e)
	return c:IsAbleToMZone() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(aux.ShieldZoneFilter(scard.tmfilter),tp,LOCATION_SZONE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	local g=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(scard.tmfilter),tp,LOCATION_SZONE,0,0,ct,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
