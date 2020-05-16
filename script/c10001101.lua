--Poisonous Dahlia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
