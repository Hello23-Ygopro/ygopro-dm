--Asra, Vizier of Safety
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (power up)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,0,aux.WaveStrikerCondition)
	aux.EnableUpdatePower(c,4000,aux.WaveStrikerCondition)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	--wave striker (blocker)
	aux.EnableBlocker(c,aux.WaveStrikerCondition)
	aux.AddEffectDescription(c,2,aux.WaveStrikerCondition)
end
