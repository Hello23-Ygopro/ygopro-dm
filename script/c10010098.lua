--Tajimal, Vizier of Aqua
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--power up
	aux.EnableUpdatePower(c,4000,aux.SelfBattlingCondition(aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATION_FIRE)))
end
