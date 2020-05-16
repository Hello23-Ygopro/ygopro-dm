--Enigmatic Cascade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--discard, draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--discard, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_HAND,0,e:GetHandler())
	local ct2=Duel.DiscardHand(tp,aux.TRUE,0,ct1,REASON_EFFECT,e:GetHandler())
	if ct2==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,ct2,REASON_EFFECT)
end
