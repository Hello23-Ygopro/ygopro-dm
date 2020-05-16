--Wisp Howler, Shadow of Tears
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer (nature and light)
	aux.EnableSlayer(c,nil,DESC_NL_SLAYER,aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATIONS_LN))
end
