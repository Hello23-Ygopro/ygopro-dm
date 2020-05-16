--蒼神龍ウォルフィース
--Wolfis, Blue Divine Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRaceCategory(c,RACECAT_CYBER,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BREAK_SHIELD,true,nil,scard.op1,nil,scard.con1)
	--destroy replace (return)
	aux.AddSingleReplaceEffectDestroy(c,1,scard.tg1,scard.op2)
end
--get ability
function scard.cfilter(c,tp)
	return c:GetPreviousControler()==tp and not c:IsHasEffect(EFFECT_SHIELD_TRIGGER)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	for tc in aux.Next(g) do
		if tc:IsLocation(LOCATION_HAND) and tc:IsBrokenShield() and not tc:IsHasEffect(EFFECT_SHIELD_TRIGGER) then
			--shield trigger
			aux.AddTempEffectCustom(e:GetHandler(),tc,3,EFFECT_SHIELD_TRIGGER)
			Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_BECOME_SHIELD_TRIGGER,e,0,0,0,0)
			if tc:IsCreature() and tc:IsAbleToBZone(e,0,tp,false,false) then
				Duel.SendtoBZone(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
			end
		end
	end
end
--destroy replace (return)
scard.tg1=aux.SingleReplaceDestroyTarget2(2,Card.IsAbleToHand)
scard.op2=aux.SingleReplaceDestroyOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
