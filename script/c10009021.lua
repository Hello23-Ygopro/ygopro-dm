--Scout Cluster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_CLUSTER)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--return
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--return
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)
end
