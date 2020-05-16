--聖神龍アルティメス
--Altimeth, Holy Divine Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HOLY_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_UNTAP_STEP,true,nil,scard.op1)
	--to shield zone
	aux.AddSingleTriggerEffectLeaveBZone(c,1,nil,nil,aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1))
	--tap
	aux.AddSingleTriggerEffect(c,2,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op2)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--blocker
		aux.AddTempEffectBlocker(e:GetHandler(),tc,3,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.CheckCardFunction(scard.posfilter,0,LOCATION_BZONE)
scard.op2=aux.TapOperation(nil,scard.posfilter,0,LOCATION_BZONE)
