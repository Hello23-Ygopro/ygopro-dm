--Gigaslug
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--slayer
	aux.EnableSlayer(c)
	--cannot attack
	aux.EnableCannotAttack(c)
end
