--Gigabuster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--cannot attack
	aux.EnableCannotAttack(c)
end
--to hand
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsAbleToHand),LOCATION_SZONE,0,1,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation()
