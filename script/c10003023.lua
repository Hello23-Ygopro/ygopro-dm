--Baraga, Blade of Gloom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsAbleToHand),LOCATION_SZONE,0,1,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation()
