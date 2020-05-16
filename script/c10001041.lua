--Teleportation
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.retfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.retfilter,LOCATION_BZONE,LOCATION_BZONE,0,2,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation()
