--Cosmic Darts
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--confirm shield, cast for no cost
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--confirm shield, cast for no cost
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.ShieldZoneFilter(),LOCATION_SZONE,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	if tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
	if tc:IsSpell() then
		Duel.CastFree(tc,REASON_EFFECT)
	end
end
