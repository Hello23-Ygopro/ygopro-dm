--Betrale, the Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--untap
	aux.EnableTurnEndSelfUntap(c)
end
