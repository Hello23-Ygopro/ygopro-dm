--Garkago Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--attack untapped
	aux.EnableAttackUntapped(c)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_FIRE)
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,0,c)*1000
end
