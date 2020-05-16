--Deklowaz, the Terminator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (destroy, discard)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (destroy, discard)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(3000)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,1,nil)
		or Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND,1,nil) end
end
function scard.dhfilter(c)
	return c:IsPowerBelow(3000)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	Duel.Destroy(g1,REASON_EFFECT)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.ConfirmCards(tp,g2)
	local sg=g2:Filter(scard.dhfilter,nil)
	Duel.DMSendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
