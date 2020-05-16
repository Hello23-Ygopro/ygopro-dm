--Venom Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (get ability)
	aux.EnableTapAbility(c,0,nil,scard.op1)
end
--tap ability (get ability)
function scard.abfilter(c,race)
	return c:IsFaceup() and c:DMIsRace(race)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCERACE)
	local race=Duel.DMAnnounceRace(tp)
	local g=Duel.GetMatchingGroup(scard.abfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,race)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--slayer
		aux.AddTempEffectSlayer(e:GetHandler(),tc,1)
	end
end
