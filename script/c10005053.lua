--Nocturnal Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,7000)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--cannot attack creature
	aux.EnableCannotAttackCreature(c)
end
