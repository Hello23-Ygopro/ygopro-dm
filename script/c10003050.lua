--Pouch Shell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave
function scard.tgfilter(c)
	return c:IsFaceup() and c:IsEvolution() and c:IsHasEvolutionSource() and c:DMIsAbleToGrave()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tgfilter,0,LOCATION_BZONE,1,1,HINTMSG_TOGRAVE)
scard.op1=aux.TargetCardsOperation(Duel.DMSendTopCardtoGrave,REASON_EFFECT)
