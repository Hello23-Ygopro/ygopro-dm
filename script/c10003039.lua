--Flametropus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1)
end
--to grave
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(Card.DMIsAbleToGrave),LOCATION_MZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.DMIsAbleToGrave),tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()==0 or Duel.DMSendtoGrave(g,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	--power attacker
	aux.AddTempEffectPowerAttacker(c,c,1,3000,0)
	--double breaker
	aux.AddTempEffectBreaker(c,c,2,EFFECT_DOUBLE_BREAKER,0)
end
