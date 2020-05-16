--Warped Lunatron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_MOON)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (do not untap)
	aux.EnableEffectCustom(c,EFFECT_DONOT_UNTAP_START_STEP,nil,LOCATION_BZONE,LOCATION_BZONE)
	--tap, untap
	aux.AddTriggerEffect(c,0,EVENT_CUSTOM+EVENT_UNTAP_START_STEP,true,scard.tg1,scard.op1,nil,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--tap, untap
function scard.cfilter(c,tp)
	return c:IsControler(tp) and c:IsUntapped()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and eg:IsExists(scard.cfilter,1,nil,tp)
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(Card.IsAbleToTap),LOCATION_MZONE,0)
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(aux.ManaZoneFilter(Card.IsAbleToTap),tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g1=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.IsAbleToTap),tp,LOCATION_MZONE,0,1,ct1,nil)
	local ct2=Duel.Tap(g1,REASON_EFFECT)
	if ct2<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNTAP)
	local g2=Duel.SelectMatchingCard(tp,scard.posfilter,tp,LOCATION_BZONE,0,math.floor(ct2/2),math.floor(ct2/2),nil)
	if g2:GetCount()==0 then return end
	Duel.HintSelection(g2)
	Duel.Untap(g2,REASON_EFFECT)
end
