--Olgate, Nightmare Samurai
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap
	aux.AddTriggerEffect(c,0,EVENT_DESTROYED,true,aux.SelfUntapTarget,scard.op1,nil,scard.con1)
end
--untap
function scard.cfilter(c,tp)
	return c:IsCreature() and c:GetPreviousControler()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.Untap(c,REASON_EFFECT)
end
