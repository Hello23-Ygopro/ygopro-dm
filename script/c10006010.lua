--Splinterclaw Wasp
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1))
end
