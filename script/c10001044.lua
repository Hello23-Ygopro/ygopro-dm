--Virtual Tripwire
--エレメンタル・トラップ (Elemental Trap)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddNameCategory(c,NAMECAT_TRAP)
	--spell
	aux.EnableSpellAttribute(c)
	--tap
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,1,1,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
