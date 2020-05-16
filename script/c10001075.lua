--Draglide
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--must attack
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK)
end
