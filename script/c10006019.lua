--Forbos, Sanctum Guardian Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (search - to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
	aux.AddSingleGrantTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1,nil,LOCATION_ALL,0,scard.tg1)
end
--survivor (search - to hand)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,Card.IsSpell,LOCATION_DECK,0,0,1,true)
scard.tg1=aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR)
