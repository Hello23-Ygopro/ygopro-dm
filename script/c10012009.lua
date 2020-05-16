--Meloppe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--change shield choose player
	aux.EnablePlayerEffectCustom(c,EFFECT_CHANGE_SHIELD_CHOOSE_PLAYER,1,1)
end
