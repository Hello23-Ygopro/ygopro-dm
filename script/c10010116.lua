--Ultimate Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--crew breaker
	aux.EnableCrewBreaker(c,aux.FilterBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsRaceCategory(RACECAT_DRAGON)
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,0,c)*5000
end
