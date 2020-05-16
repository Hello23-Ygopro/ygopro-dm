--Blaze Cannon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1,nil,scard.con1)
end
--get ability
scard.con1=aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_FIRE)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power attacker
		aux.AddTempEffectPowerAttacker(e:GetHandler(),tc,1,4000)
		--double breaker
		aux.AddTempEffectBreaker(e:GetHandler(),tc,2,EFFECT_DOUBLE_BREAKER)
	end
end
