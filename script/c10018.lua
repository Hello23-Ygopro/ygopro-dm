--ハリケーン・フィッシュ
--Hurricane Fish
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DrawOperation(PLAYER_SELF,1))
	--return
	aux.AddTriggerEffect(c,1,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
end
--return
scard.con1=aux.TurnPlayerCondition(PLAYER_SELF)
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil):RandomSelect(tp,1)
	Duel.HintSelection(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
