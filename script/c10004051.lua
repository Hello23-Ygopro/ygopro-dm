--Exploding Cactus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.ExistingCardCondition(scard.cfilter))
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_LIGHT)
end
