--Melnia, the Aqua Shadow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--slayer
	aux.EnableSlayer(c)
end
