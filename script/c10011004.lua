--Miraculous Snare
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to shield zone
function scard.tsfilter(c)
	return c:IsFaceup() and not c:IsEvolution() and c:IsAbleToSZone()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tsfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_TOSZONE)
scard.op1=aux.TargetSendtoSZoneOperation
