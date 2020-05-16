--Nightmare Invader
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEVIL_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
end
