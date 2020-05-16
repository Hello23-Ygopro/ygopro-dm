--Lockdown Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot use tap ability
	aux.EnablePlayerEffectCustom(c,EFFECT_CANNOT_USE_TAP_ABILITY,1,1)
end
