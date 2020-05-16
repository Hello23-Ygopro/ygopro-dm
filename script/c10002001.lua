--Diamond Cutter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.abfilter(c)
	return c:IsFaceup() and (not c:IsCanAttackTurn() or not c:IsCanAttack() or not c:IsCanAttackPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.abfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--ignore summoning sickness
		aux.AddTempEffectCustom(c,tc,1,EFFECT_IGNORE_SUMMONING_SICKNESS)
		--ignore cannot attack
		aux.AddTempEffectCustom(c,tc,2,EFFECT_IGNORE_CANNOT_ATTACK)
		--ignore cannot attack player
		aux.AddTempEffectCustom(c,tc,2,EFFECT_IGNORE_CANNOT_ATTACK_PLAYER)
	end
end
