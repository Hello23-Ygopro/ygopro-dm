--Sapian Tark, Flame Dervish
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (power up)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,0,aux.WaveStrikerCondition)
	aux.EnableUpdatePower(c,4000,aux.WaveStrikerCondition)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	--wave striker (attack untapped)
	aux.EnableAttackUntapped(c,nil,aux.WaveStrikerCondition)
	aux.AddEffectDescription(c,2,aux.WaveStrikerCondition)
end
