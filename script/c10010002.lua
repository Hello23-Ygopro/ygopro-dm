--Ryudmila, Channeler of Suns
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_DEL_SOL)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--destroy replace (to deck)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,0,c)*2000
end
--destroy replace (to deck)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToDeck)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoDeck,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT+REASON_REPLACE)
