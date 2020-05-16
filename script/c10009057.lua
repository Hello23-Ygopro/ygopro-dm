--Aqua Master
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--confirm shield
scard.con1=aux.AND(aux.UnblockedCondition,aux.AttackPlayerCondition)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE,1)
scard.op1=aux.TargetConfirmOperation(true)
