--Sea Mutant Dormel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MERFOLK,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
end
