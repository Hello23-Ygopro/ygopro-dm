--Vess, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
