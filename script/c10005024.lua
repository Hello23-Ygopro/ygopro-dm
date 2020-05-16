--Split-Head Hydroturtle Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (draw)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	aux.AddSingleGrantTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,nil,LOCATION_ALL,0,scard.tg2)
end
--survivor (draw)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
scard.op1=aux.DrawOperation(PLAYER_SELF,1)
scard.tg2=aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR)
