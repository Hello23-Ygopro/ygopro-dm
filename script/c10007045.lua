--Wild Racer Chief Garan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,1000)
	--stealth (light)
	aux.EnableStealth(c,CIVILIZATION_LIGHT)
end
