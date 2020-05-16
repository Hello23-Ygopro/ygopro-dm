--Necrodragon Jagraveen
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_END,nil,nil,aux.SelfDestroyOperation(),nil,aux.SelfBlockCondition)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
