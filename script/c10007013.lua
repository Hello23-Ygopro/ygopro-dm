--Rodi Gale, Night Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--stealth (darkness)
	aux.EnableStealth(c,CIVILIZATION_DARKNESS)
end
