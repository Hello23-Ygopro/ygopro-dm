--Angler Cluster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_CLUSTER)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack
	aux.EnableCannotAttack(c)
	--power up
	aux.EnableUpdatePower(c,3000,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_WATER))
	aux.AddEffectDescription(c,0,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_WATER))
end
