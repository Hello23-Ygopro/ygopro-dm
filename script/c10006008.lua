--Valiant Warrior Exorious
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
end
