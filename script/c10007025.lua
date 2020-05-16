--Trenchdive Shark
--Note: Changed effect to match YGOPro's game system
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--to shield zone, to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to shield zone, to hand
scard.tg1=aux.CheckCardFunction(Card.IsAbleToSZone,LOCATION_HAND,0)
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	--local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToSZone,tp,LOCATION_HAND,0,1,2,nil)
	--if g1:GetCount()==0 or Duel.SendtoSZone(g1)==0 then return end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	--local g2=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(scard.thfilter),tp,LOCATION_SZONE,0,g1:GetCount(),g1:GetCount(),nil,e)
	--if g2:GetCount()==0 then return end
	--Duel.SetTargetCard(g2)
	--Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(Card.IsAbleToSZone,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	local sg1=g:Select(tp,1,2,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg2=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(scard.thfilter),tp,LOCATION_SZONE,0,sg1:GetCount(),sg1:GetCount(),nil,e)
	if sg2:GetCount()==0 then return end
	Duel.SetTargetCard(sg2)
	Duel.SendtoHand(sg2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ShuffleHand(tp)
	Duel.SendtoSZone(sg1)
end
