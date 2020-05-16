--Mykee's Pliers
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_XENOPARTS)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (speed attacker)
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATIONS_DN))
end
