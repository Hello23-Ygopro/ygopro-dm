--Tentacle Cluster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_CLUSTER)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--return
scard.con1=aux.AND(aux.UnblockedCondition,aux.AttackPlayerCondition)
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation()
