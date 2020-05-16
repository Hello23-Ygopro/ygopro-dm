--Lurking Eel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker (fire and nature)
	aux.EnableBlocker(c,nil,DESC_FN_BLOCKER,aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATIONS_FN))
end
