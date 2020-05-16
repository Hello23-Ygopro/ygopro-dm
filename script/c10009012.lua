--Mihail, Celestial Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be destroyed
	aux.EnableCannotBeDestroyed(c,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunctionExceptSelf())
end
