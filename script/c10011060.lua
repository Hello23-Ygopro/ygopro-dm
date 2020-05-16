--Miraculous Rebirth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy, search (to battle zone)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy, search (to battle zone)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(5000)
end
function scard.tbfilter(c,e,tp,cost)
	return c:IsCreature() and c:IsManaCost(cost) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectMatchingCard(tp,scard.desfilter,tp,0,LOCATION_BZONE,1,1,nil):GetFirst()
	if not tc then return end
	Duel.HintSelection(Group.FromCards(tc))
	if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
	local cost=tc:GetManaCost()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,cost)
	if g:GetCount()==0 then return end
	Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
