--Rumblesaur Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (speed attacker)
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER,nil,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
