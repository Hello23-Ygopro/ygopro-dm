--Ballus, Dogfight Enforcer Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (untap)
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,aux.HintTarget,scard.op1,nil,scard.con1)
	aux.AddGrantTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,aux.HintTarget,scard.op1,nil,LOCATION_ALL,0,scard.tg1,scard.con1)
end
--survivor (untap)
scard.con1=aux.AND(aux.SelfTappedCondition,aux.TurnPlayerCondition(PLAYER_SELF))
scard.op1=aux.SelfUntapOperation()
scard.tg1=aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR)
