--剛撃戦攻ドルゲーザ
--Dolgeza, Veteran of Hard Battle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--sympathy (earth eater, giant)
	aux.EnableSympathy(c,RACE_EARTH_EATER,RACE_GIANT)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--draw
function scard.cfilter(c,race)
	return c:IsFaceup() and c:DMIsRace(race)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and (Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil,RACE_EARTH_EATER)
		or Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil,RACE_GIANT)) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(scard.cfilter,tp,LOCATION_BZONE,0,nil,RACE_EARTH_EATER)
	if ct1>0 then
		Duel.Draw(tp,ct1,REASON_EFFECT)
	end
	local ct2=Duel.GetMatchingGroupCount(scard.cfilter,tp,LOCATION_BZONE,0,nil,RACE_GIANT)
	if ct2>0 and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.BreakEffect()
		Duel.Draw(tp,ct2,REASON_EFFECT)
	end
end
