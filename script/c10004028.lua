--Darkpact
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to grave, draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to grave, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(aux.ManaZoneFilter(Card.DMIsAbleToGrave),tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.DMIsAbleToGrave),tp,LOCATION_MZONE,0,0,ct1,nil)
	if g:GetCount()==0 then return end
	local ct2=Duel.DMSendtoGrave(g,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(tp,ct2,REASON_EFFECT)
end
