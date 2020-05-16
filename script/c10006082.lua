--Migasa, Adept of Chaos
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (get ability)
	aux.EnableTapAbility(c,0,aux.CheckCardFunction(scard.abfilter,LOCATION_BZONE,0),scard.op1)
end
--tap ability (get ability)
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_FIRE)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,scard.abfilter,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--double breaker
	aux.AddTempEffectBreaker(e:GetHandler(),g:GetFirst(),1,EFFECT_DOUBLE_BREAKER)
end
