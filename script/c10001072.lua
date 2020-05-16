--Chaos Strike
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
function scard.abfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.abfilter,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not scard.abfilter(tc) then return end
	--make attackable
	aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_UNTAPPED_BE_ATTACKED)
end
