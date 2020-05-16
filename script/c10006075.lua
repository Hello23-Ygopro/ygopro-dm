--Bazagazeal Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.EnableTurnEndSelfReturn(c)
end
