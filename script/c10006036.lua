--Kyuroro
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--change shield break player
	aux.EnablePlayerEffectCustom(c,EFFECT_CHANGE_SHIELD_BREAK_PLAYER,1,0)
end
