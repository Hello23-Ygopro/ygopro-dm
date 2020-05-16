--神楽妖精パルティア
--Parthia, Dancing Faerie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to deck
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to deck
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DMGraveFilter(Card.IsAbleToDeck),LOCATION_GRAVE,0,0,3,HINTMSG_TODECK)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDeck,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
