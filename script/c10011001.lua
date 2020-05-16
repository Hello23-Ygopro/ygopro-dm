--Evil Incarnate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEVIL_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DEVIL_MASK))
	--destroy
	aux.AddTriggerEffect(c,0,EVENT_UNTAP_STEP,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
scard.evolution_race_list={RACE_DEVIL_MASK}
--destroy
--Note: Moved card targeting to the operation function in the event opponent also has Evil Incarnate in the battle zone
--This prevents the turn player from choosing the same monster again to destroy as the chain resolves
--[[
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local turnp=Duel.GetTurnPlayer()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(turnp) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,turnp,HINTMSG_DESTROY)
	Duel.SelectTarget(turnp,Card.IsFaceup,turnp,LOCATION_BZONE,0,1,1,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
]]
function scard.desfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.Hint(HINT_SELECTMSG,turnp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(turnp,scard.desfilter,turnp,LOCATION_BZONE,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.Destroy(g,REASON_EFFECT)
end
