--Smile Angler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ManaZoneFilter(Card.IsAbleToHand),0,LOCATION_MZONE,1,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation()
