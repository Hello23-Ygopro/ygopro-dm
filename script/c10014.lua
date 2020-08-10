--再生の使徒ノルカ・ソルカ
--Nolka Solka, Vizier of Regeneration
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-3,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsSpell))
	--tap ability (return)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap ability (return)
function scard.thfilter1(c)
	return c:IsSpell() and c:IsAbleToHand()
end
function scard.thfilter2(c,e)
	return scard.thfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.ManaZoneFilter(scard.thfilter1)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and f(chkc) end
	if chk==0 then return Duel.IsExistingTarget(f,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(aux.ManaZoneFilter(scard.thfilter2),tp,LOCATION_MZONE,0,nil,e):RandomSelect(tp,1)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetSendtoHandOperation()
