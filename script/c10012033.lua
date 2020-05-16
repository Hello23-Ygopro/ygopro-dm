--Gigappi Ponto
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
end
