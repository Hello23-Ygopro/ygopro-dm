--Forest Hornet
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
end
