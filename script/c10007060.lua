--Headlong Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,aux.NoHandCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,1,aux.NoHandCondition(PLAYER_SELF))
	--attack cost (discard)
	aux.AddAttackCost(c,scard.cost1,scard.op1)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedBoolFunction(Card.IsPowerBelow,4000))
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
end
--attack cost (discard)
function scard.cost1(e,c,tp)
	return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST)
	Duel.AttackCostPaid()
end
--[[
	References
		1. The Dragon's Bead
		https://github.com/Fluorohydride/ygopro-scripts/blob/f24eb49/c92408984.lua#L37
]]
