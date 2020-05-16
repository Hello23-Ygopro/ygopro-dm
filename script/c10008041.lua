--Rocketdive Skyterror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--power attacker
	aux.EnablePowerAttacker(c,1000)
end
