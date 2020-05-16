--Dedreen, the Hidden Corrupter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PANDORAS_BOX)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--discard
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetShieldCount(1-tp)<=3
end
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1,1,true)
