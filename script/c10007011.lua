--Miracle Portal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	local c=e:GetHandler()
	--cannot be blocked
	aux.AddTempEffectCannotBeBlocked(c,tc,1)
	--ignore summoning sickness
	aux.AddTempEffectCustom(c,tc,2,EFFECT_IGNORE_SUMMONING_SICKNESS)
	--ignore cannot attack
	aux.AddTempEffectCustom(c,tc,3,EFFECT_IGNORE_CANNOT_ATTACK)
	--ignore cannot attack player
	aux.AddTempEffectCustom(c,tc,3,EFFECT_IGNORE_CANNOT_ATTACK_PLAYER)
end
