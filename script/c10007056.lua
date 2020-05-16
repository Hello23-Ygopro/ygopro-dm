--Siri, Glory Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--blocker
	aux.EnableBlocker(c,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,1,aux.NoShieldsCondition(PLAYER_SELF))
	--untap
	aux.EnableTurnEndSelfUntap(c,0,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,2,aux.NoShieldsCondition(PLAYER_SELF))
end
