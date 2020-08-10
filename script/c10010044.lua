--Zaltan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard, return
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--discard, return
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp and c:DMIsRace(RACE_CYBER_VIRUS)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
scard.tg1=aux.CheckCardFunction(aux.TRUE,LOCATION_HAND,0)
function scard.thfilter(c,e)
	return c:IsFaceup() and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.DiscardHand(tp,aux.TRUE,1,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,ct,ct,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
