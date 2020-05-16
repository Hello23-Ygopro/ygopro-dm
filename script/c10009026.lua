--Acid Reflux, the Fleshboiler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEVIL_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack
	aux.EnableCannotAttack(c)
	--slayer
	aux.EnableSlayer(c)
end
