--Gazarias Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,4000,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,0,aux.NoShieldsCondition(PLAYER_SELF))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,1,aux.NoShieldsCondition(PLAYER_SELF))
end
