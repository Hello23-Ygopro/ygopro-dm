--Comet Eye, the Spectral Spud
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIES,RACE_RAINBOW_PHANTOM)
	aux.AddEvolutionRaceList(c,RACE_WILD_VEGGIES,RACE_RAINBOW_PHANTOM)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_WILD_VEGGIES,RACE_RAINBOW_PHANTOM))
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_WILD_VEGGIES,RACE_RAINBOW_PHANTOM))
	--untap
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,scard.tg1,scard.op1,nil,scard.con1)
end
--untap
scard.con1=aux.TurnPlayerCondition(PLAYER_SELF)
function scard.posfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_WILD_VEGGIES,RACE_RAINBOW_PHANTOM) and c:IsAbleToUntap()
end
scard.tg1=aux.CheckCardFunction(scard.posfilter,LOCATION_BZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.posfilter,tp,LOCATION_BZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNTAP)
	local g=Duel.SelectMatchingCard(tp,scard.posfilter,tp,LOCATION_BZONE,0,1,ct,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Untap(g,REASON_EFFECT)
end
