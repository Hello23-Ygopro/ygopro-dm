--Deadly Fighter Braid Claw
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--must attack
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK)
end
