--Biancus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--tap ability (get ability)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap ability (get ability)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	--cannot be blocked
	aux.AddTempEffectCannotBeBlocked(e:GetHandler(),tc,1)
end
