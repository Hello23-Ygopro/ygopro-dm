--Poltalester, the Spydroid
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SOLTROOPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
