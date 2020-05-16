--Slash and Burn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--to grave
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--to grave
function scard.cfilter(c,tp)
	return c:IsCreature() and c:GetPreviousControler()~=tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp)
end
function scard.tgfilter(c,e)
	return c:DMIsAbleToGrave() and c:IsCanBeEffectTarget(e)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.ManaZoneFilter(scard.tgfilter),tp,0,LOCATION_MZONE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.ShieldZoneFilter(scard.tgfilter),tp,0,LOCATION_SZONE,nil,e)
	if g1:GetCount()==0 and g2:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	scard.tograve(g1,1-tp)
	Duel.BreakEffect()
	scard.tograve(g2,1-tp)
end
function scard.tograve(g,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
	Duel.DMSendtoGrave(sg,REASON_EFFECT)
end
