--Gankloak, Rogue Commando
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (get ability)
	aux.EnableSilentSkill(c,0,aux.CheckCardFunction(scard.abfilter,LOCATION_BZONE,0),scard.op1)
end
--silent skill (get ability)
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_FIRE)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.abfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--double breaker
		aux.AddTempEffectBreaker(e:GetHandler(),tc,1,EFFECT_DOUBLE_BREAKER)
	end
end
