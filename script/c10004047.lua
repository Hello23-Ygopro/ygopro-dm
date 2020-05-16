--Sword of Malevolent Death
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,scard.val1,nil,nil,aux.SelfAttackerCondition)
	end
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.ManaZoneFilter(Card.IsCivilization),c:GetControler(),LOCATION_MZONE,0,nil,CIVILIZATION_DARKNESS)*1000
end
