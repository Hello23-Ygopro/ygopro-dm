--Burnwisp Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (speed attacker)
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_SILENT_SKILL))
end
