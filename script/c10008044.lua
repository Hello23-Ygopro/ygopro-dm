--Totto Pipicchi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (speed attacker)
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
end
