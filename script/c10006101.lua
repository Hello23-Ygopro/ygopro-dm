--Garabon, the Glider
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,2000)
end
