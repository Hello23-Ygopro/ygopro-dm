--Baira, the Hidden Lunatic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PANDORAS_BOX)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack
	aux.EnableCannotAttack(c)
	--destroy
	aux.EnableBattleEndSelfDestroy(c)
end
