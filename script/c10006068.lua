--Tentacle Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
end
