--Steam Rumbler Kain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ShieldZoneFilter(Card.DMIsAbleToGrave),LOCATION_SZONE,0,1,1,HINTMSG_TOGRAVE)
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
