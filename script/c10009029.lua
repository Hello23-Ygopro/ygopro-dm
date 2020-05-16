--Grinning Hunger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to grave
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave
function scard.tgfilter1(c,e)
	return c:IsFaceup() and c:DMIsAbleToGrave() and c:IsCanBeEffectTarget(e)
end
function scard.tgfilter2(c,e)
	return c:DMIsAbleToGrave() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	local g1=Duel.GetMatchingGroup(scard.tgfilter1,tp,0,LOCATION_BZONE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.ShieldZoneFilter(scard.tgfilter2),0,LOCATION_SZONE,nil,e)
	g1:Merge(g2)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local sg=g1:Select(1-tp,1,1,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
