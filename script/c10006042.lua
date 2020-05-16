--Promephius Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
end
