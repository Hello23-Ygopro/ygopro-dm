--Photocide, Lord of the Wastes
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--attack untapped
	aux.EnableAttackUntapped(c,CIVILIZATION_LIGHT)
end
