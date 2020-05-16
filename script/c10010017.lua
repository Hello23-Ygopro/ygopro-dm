--Ikaz, the Spydroid
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SOLTROOPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_END,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfBlockCondition)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,LOCATION_BZONE,0,1,1,HINTMSG_UNTAP)
scard.op1=aux.TargetCardsOperation(Duel.Untap,REASON_EFFECT)
