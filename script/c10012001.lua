--Kilstine, Nebula Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (power up)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,0,aux.WaveStrikerCondition)
	aux.EnableUpdatePower(c,5000,aux.WaveStrikerCondition,LOCATION_BZONE,0)
	--wave striker (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,0,nil,aux.WaveStrikerCondition)
	--wave striker (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.WaveStrikerCondition,LOCATION_BZONE,0)
end
