--Necrodragon Galbazeek
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--to grave
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ShieldZoneFilter(Card.DMIsAbleToGrave),LOCATION_SZONE,0,1,1,HINTMSG_TOGRAVE)
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
