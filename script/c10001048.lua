--Bone Spider
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_DEAD)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.EnableBattleWinSelfDestroy(c)
end
