--Pinpoint Lunatron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_MOON)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.thfilter1(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function scard.chkcfilter(c)
	return scard.thfilter1(c)
		or Duel.IsExistingTarget(aux.ManaZoneFilter(Card.IsAbleToHand),0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function scard.thfilter2(c,e)
	return scard.thfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.thfilter3(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE+LOCATION_MZONE) and scard.chkcfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(scard.thfilter1,tp,LOCATION_BZONE,LOCATION_BZONE,1,nil)
		or Duel.IsExistingTarget(aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g1=Duel.GetMatchingGroup(scard.thfilter2,tp,LOCATION_BZONE,LOCATION_BZONE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.ManaZoneFilter(scard.thfilter3),tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g1:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetSendtoHandOperation()
