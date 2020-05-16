--Mega Detonator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
function scard.abfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct1=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_HAND,0,c)
	local ct2=Duel.DiscardHand(tp,aux.TRUE,0,ct1,REASON_EFFECT,c)
	if ct2==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,scard.abfilter,tp,LOCATION_BZONE,LOCATION_BZONE,ct2,ct2,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	for tc in aux.Next(g) do
		--double breaker
		aux.AddTempEffectBreaker(c,tc,1,EFFECT_DOUBLE_BREAKER)
	end
end
