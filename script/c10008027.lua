--Cranium Clamp
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--discard
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--discard
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,2,2,HINTMSG_DISCARD)
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT+REASON_DISCARD)
