--Spinal Parasite
--ポゼスト・マフラー (Pozesuto Muffler)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_UNTAP_STEP,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--get ability
scard.con1=aux.TurnPlayerCondition(PLAYER_OPPO)
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCanAttack()
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,scard.abfilter,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not scard.abfilter(tc) then return end
	--must attack
	aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_MUST_ATTACK)
end
