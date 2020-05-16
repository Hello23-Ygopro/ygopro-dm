--Armored Warrior Quelos
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave
function scard.tgfilter1(c)
	return not c:IsCivilization(CIVILIZATION_FIRE) and c:DMIsAbleToGrave()
end
function scard.tgfilter2(c,e)
	return scard.tgfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.tgfilter1),tp,LOCATION_MZONE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.DMSendtoGrave(g1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(1-tp,aux.ManaZoneFilter(scard.tgfilter2),1-tp,LOCATION_MZONE,0,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.DMSendtoGrave(g2,REASON_EFFECT)
end
