--Roulette of Ruin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--discard
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--discard
function scard.dhfilter(c,cost)
	return c:IsManaCost(cost)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local cost=Duel.AnnounceCost(tp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	g1:RemoveCard(e:GetHandler())
	if g1:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g1)
		local sg1=g1:Filter(scard.dhfilter,nil,cost)
		Duel.DMSendtoGrave(sg1,REASON_EFFECT+REASON_DISCARD)
	end
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g2:GetCount()>0 then
		Duel.BreakEffect()
		Duel.ConfirmCards(tp,g2)
		local sg2=g2:Filter(scard.dhfilter,nil,cost)
		Duel.DMSendtoGrave(sg2,REASON_EFFECT+REASON_DISCARD)
	end
end
