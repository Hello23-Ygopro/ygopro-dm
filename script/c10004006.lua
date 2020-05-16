--Aeris, Flight Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--attack untapped
	aux.EnableAttackUntapped(c,CIVILIZATION_DARKNESS)
end
