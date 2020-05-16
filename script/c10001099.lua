--Natural Snare
--ナチュラル・トラップ (Natural Trap)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddNameCategory(c,NAMECAT_TRAP)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to mana zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsAbleToMZone()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tmfilter,0,LOCATION_BZONE,1,1,HINTMSG_TOMZONE)
scard.op1=aux.TargetCardsOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT)
