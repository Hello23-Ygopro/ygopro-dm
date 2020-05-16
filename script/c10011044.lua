--Macho Melon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIES)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (power attacker)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,0,aux.WaveStrikerCondition)
	aux.EnablePowerAttacker(c,3000,aux.WaveStrikerCondition)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
end
