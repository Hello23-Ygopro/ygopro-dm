--Junkatz, Rabid Doll
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET)
	--creature
	aux.EnableCreatureAttribute(c)
end
