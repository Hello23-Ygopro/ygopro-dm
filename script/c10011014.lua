--Yuliana, Channeler of Suns
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_DEL_SOL)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot be targeted
	aux.EnableCannotBeTargeted(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
