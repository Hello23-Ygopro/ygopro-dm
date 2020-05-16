--Buzz Betocchi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
end
