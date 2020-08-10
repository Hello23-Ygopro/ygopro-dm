--Shtra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_RTOHAND)
	local g2=Duel.SelectMatchingCard(1-tp,aux.ManaZoneFilter(scard.thfilter),1-tp,LOCATION_MZONE,0,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(tp,g2)
end
