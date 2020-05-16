--Ice Vapor, Shadow of Anguish
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard, to grave
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_OPPO,nil,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--discard, to grave
function scard.dhfilter(c,e)
	return c:IsCanBeEffectTarget(e)
end
function scard.tgfilter(c,e)
	return c:DMIsAbleToGrave() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local g1=Duel.SelectMatchingCard(1-tp,scard.dhfilter,1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g1:GetCount()>0 then
		Duel.SetTargetCard(g1)
		Duel.DMSendtoGrave(g1,REASON_EFFECT+REASON_DISCARD)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(1-tp,aux.ManaZoneFilter(scard.tgfilter),1-tp,LOCATION_MZONE,0,1,1,nil,e)
	if g2:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g2)
		Duel.DMSendtoGrave(g2,REASON_EFFECT)
	end
end
