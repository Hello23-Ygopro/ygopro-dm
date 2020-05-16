--King Benthos
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap ability (get ability)
	aux.EnableTapAbility(c,0,aux.CheckCardFunction(scard.abfilter,LOCATION_BZONE,0),scard.op1)
end
--tap ability (get ability)
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_WATER)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.abfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--cannot be blocked
		aux.AddTempEffectCannotBeBlocked(e:GetHandler(),tc,1)
	end
end
