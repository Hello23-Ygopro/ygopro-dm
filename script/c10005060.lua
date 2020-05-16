--Avalanche Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot attack creature
	aux.EnableCannotAttackCreature(c)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1))
end
