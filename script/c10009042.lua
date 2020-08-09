--Shock Trooper Mykee
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--destroy
scard.con1=aux.AND(aux.UnblockedCondition,aux.AttackPlayerCondition)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_DESTROY)
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
--[[
	Notes
	* This card's effect is different in the OCG.
]]
