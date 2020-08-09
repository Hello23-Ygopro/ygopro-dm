--Metalwing Skyterror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_DESTROY)
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
--[[
	Notes
	* This card's effect is different in the OCG.
]]
