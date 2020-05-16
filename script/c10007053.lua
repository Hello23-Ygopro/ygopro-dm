--Stinger Horn, the Delver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,1000)
	--stealth (water)
	aux.EnableStealth(c,CIVILIZATION_WATER)
end
