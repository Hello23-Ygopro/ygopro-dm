--Vile Mulder, Wing of the Void
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack creature
	aux.EnableCannotAttackCreature(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.EnableBattleEndSelfDestroy(c)
end
