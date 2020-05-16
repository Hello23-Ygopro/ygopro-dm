--Rain of Arrows
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--discard
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--discard
function scard.dhfilter(c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	local sg=g:Filter(scard.dhfilter,nil)
	Duel.DMSendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
