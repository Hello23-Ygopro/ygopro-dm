--Vashuna, Sword Dancer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot attack
	aux.EnableCannotAttack(c,aux.NoShieldsCondition(PLAYER_OPPO))
	aux.AddEffectDescription(c,0,aux.NoShieldsCondition(PLAYER_OPPO))
end
