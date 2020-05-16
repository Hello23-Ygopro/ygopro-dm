--Soulswap
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--to mana zone, to battle zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to mana zone, to battle zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsAbleToMZone()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tmfilter,LOCATION_BZONE,LOCATION_BZONE,0,1,HINTMSG_TOMZONE)
function scard.tbfilter(c,e,tp,cost)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(cost)
		and c:IsAbleToBZone(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not scard.tmfilter(tc) then return end
	if Duel.SendtoMZone(tc,POS_FACEUP_UNTAPPED,REASON_EFFECT)==0 then return end
	local p=tc:GetOwner()
	local cost=Duel.GetManaCount(p)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g2=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.tbfilter),p,LOCATION_MZONE,0,1,1,nil,e,p,cost)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoBZone(g2,0,p,p,false,false,POS_FACEUP_UNTAPPED)
end
