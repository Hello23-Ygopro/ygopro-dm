--機動賢者キーン
--Keen, the Mobile Sage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--power attacker
	aux.EnablePowerAttacker(c,2500)
end
