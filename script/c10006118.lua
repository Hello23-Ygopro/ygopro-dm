--Lava Walker Executo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	aux.AddEvolutionRaceList(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DRAGO_NOID))
	--get ability (tap ability - get ability)
	aux.AddStaticEffectTapAbility(c,0,scard.tg1,scard.op1,LOCATION_BZONE,0,scard.tg2)
end
--get ability (tap ability - get ability)
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_FIRE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.abfilter,tp,LOCATION_BZONE,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,scard.abfilter,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--power up
	aux.AddTempEffectUpdatePower(e:GetHandler(),g:GetFirst(),1,3000)
end
scard.tg2=aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATION_FIRE)
