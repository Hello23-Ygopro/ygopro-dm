--Cursed Pincher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--slayer
	aux.EnableSlayer(c)
	--cannot attack
	aux.EnableCannotAttack(c)
end
