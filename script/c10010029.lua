--Ardent Lunatron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_MOON)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--must block
	aux.EnableEffectCustom(c,EFFECT_MUST_BLOCK)
	--cannot attack
	aux.EnableCannotAttack(c)
end
