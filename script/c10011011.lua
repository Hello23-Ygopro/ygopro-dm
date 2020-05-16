--Merlee, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (power up)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,0,aux.WaveStrikerCondition)
	aux.EnableUpdatePower(c,1000,aux.WaveStrikerCondition,LOCATION_BZONE,0)
end
