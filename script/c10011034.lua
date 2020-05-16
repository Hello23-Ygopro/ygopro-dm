--Brad's Cutter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_XENOPARTS)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
end
