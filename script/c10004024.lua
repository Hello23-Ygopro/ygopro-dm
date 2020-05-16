--Keeper of the Sunlit Abyss
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,1000,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATIONS_LD))
end
