--Stratosphere Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
end
--to battle zone
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,nil,0,LOCATION_HAND,0,2,HINTMSG_TOBZONE)
scard.op1=aux.TargetSendtoBZoneOperation(PLAYER_OPPO,POS_FACEUP_UNTAPPED)
