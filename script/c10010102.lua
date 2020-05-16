--Dolmarks, the Shadow Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy, to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--destroy, to grave
function scard.desfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.tgfilter(c,e)
	return c:DMIsAbleToGrave() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.Destroy(g1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.DMIsAbleToGrave),tp,LOCATION_MZONE,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.DMSendtoGrave(g2,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
	local g3=Duel.SelectMatchingCard(1-tp,scard.desfilter,1-tp,LOCATION_BZONE,0,1,1,nil,e)
	if g3:GetCount()>0 then
		Duel.SetTargetCard(g3)
		Duel.Destroy(g3,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local g4=Duel.SelectMatchingCard(1-tp,aux.ManaZoneFilter(scard.tgfilter),1-tp,LOCATION_MZONE,0,1,1,nil,e)
	if g4:GetCount()>0 then
		Duel.SetTargetCard(g4)
		Duel.DMSendtoGrave(g4,REASON_EFFECT)
	end
end
