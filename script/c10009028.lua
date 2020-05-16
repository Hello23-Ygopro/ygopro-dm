--Gabzagul, Warlord of Pain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (must attack)
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK,nil,LOCATION_BZONE,LOCATION_BZONE)
end
