--エンペラー・アロエラ
--Emperor Aloera
--Note: Changed effect to match YGOPro's game system
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	aux.AddEvolutionRaceList(c,RACE_CYBER_LORD)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.DMIsEvolutionRace,RACE_CYBER_LORD))
	--to shield zone, to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to shield zone, to hand
scard.tg1=aux.CheckCardFunction(Card.IsAbleToSZone,LOCATION_HAND,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local szone_count=Duel.GetLocationCount(tp,LOCATION_SZONE)
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	--local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToSZone,tp,LOCATION_HAND,0,1,szone_count,nil)
	--if g1:GetCount()==0 or Duel.SendtoSZone(g1)==0 then return end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	--local g2=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,g1:GetCount(),g1:GetCount(),nil)
	--Duel.HintSelection(g2)
	--Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(Card.IsAbleToSZone,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	local sg1=g:Select(tp,1,szone_count,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg2=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,sg1:GetCount(),sg1:GetCount(),nil)
	if sg2:GetCount()==0 then return end
	Duel.HintSelection(sg2)
	Duel.SendtoHand(sg2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ShuffleHand(tp)
	Duel.SendtoSZone(sg1)
end
