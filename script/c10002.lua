--アクア・ハンター
--Aqua Hunter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--wins all battles (beast folk)
	aux.EnableWinsAllBattles(c,0,aux.FilterBoolFunction(Card.DMIsRace,RACE_BEAST_FOLK))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
end
