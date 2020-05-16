--Neon Cluster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_CLUSTER)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (draw)
	aux.EnableTapAbility(c,0,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2))
end
