--Trox, General of Destruction
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--discard
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.cfilter,tp,LOCATION_BZONE,0,e:GetHandler())
	Duel.RandomDiscardHand(1-tp,ct,REASON_EFFECT)
end
