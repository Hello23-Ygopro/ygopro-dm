--Riptide Charger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--charger
	aux.EnableEffectCustom(c,EFFECT_CHARGER)
end
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation()
