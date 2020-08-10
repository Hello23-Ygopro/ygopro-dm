--Eldritch Poison
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy, return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy, return
function scard.desfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,scard.desfilter,tp,LOCATION_BZONE,0,0,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.Destroy(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g2=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.thfilter),tp,LOCATION_MZONE,0,1,1,nil)
	if g2:GetCount()==0 then return end
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g2)
end
