--Daidalos, General of Fury
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack cost (destroy)
	aux.AddAttackCost(c,scard.cost1,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--attack cost (destroy)
function scard.cfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function scard.cost1(e,c,tp)
	return Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,e:GetHandler())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_BZONE,0,1,1,e:GetHandler())
	Duel.Destroy(g,REASON_COST)
	Duel.AttackCostPaid()
end
