--Super Dragon Machine Dolzark
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_EARTH_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--to mana zone
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsRaceCategory(RACECAT_DRAGON) and tc~=e:GetHandler()
end
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(5000) and c:IsAbleToMZone()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tmfilter,0,LOCATION_BZONE,1,1,HINTMSG_TOMZONE)
scard.op1=aux.TargetCardsOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT)
