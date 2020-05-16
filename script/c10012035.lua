--Spectral Horn Glitalis
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST,RACE_RAINBOW_PHANTOM)
	--creature
	aux.EnableCreatureAttribute(c)
end
