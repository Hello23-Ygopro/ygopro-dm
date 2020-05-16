--Rimuel, Cloudbreak Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--tap
function scard.cfilter(c)
	return c:IsUntapped() and c:IsCivilization(CIVILIZATION_LIGHT)
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(aux.ManaZoneFilter(scard.cfilter),tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g=Duel.SelectMatchingCard(tp,scard.posfilter,tp,0,LOCATION_BZONE,ct,ct,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Tap(g,REASON_EFFECT)
end
