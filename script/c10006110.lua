--Trench Scarab
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--power attacker
	aux.EnablePowerAttacker(c,4000)
end
