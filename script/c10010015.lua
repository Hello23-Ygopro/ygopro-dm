--Flohdani, the Spydroid
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SOLTROOPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (tap)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--silent skill (tap)
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,1,2,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
