--Royal Durian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIES)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to mana zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsEvolution() and c:IsHasEvolutionSource() and c:IsAbleToMZone()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tmfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	Duel.SendTopCardtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
