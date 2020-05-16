--Illusory Berry
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
end
