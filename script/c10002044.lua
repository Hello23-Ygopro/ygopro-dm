--Rumble Gate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCanAttackCreature()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g1:GetCount()>0 then
		for tc1 in aux.Next(g1) do
			--power up
			aux.AddTempEffectUpdatePower(c,tc1,1,1000)
		end
	end
	local g2=Duel.GetMatchingGroup(scard.abfilter,tp,LOCATION_BZONE,0,nil)
	if g2:GetCount()==0 then return end
	for tc2 in aux.Next(g2) do
		--attack untapped
		aux.AddTempEffectCustom(c,tc2,2,EFFECT_ATTACK_UNTAPPED)
	end
end
