--Roaring Great-Horn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,2000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
