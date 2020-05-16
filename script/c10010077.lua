--Taunting Skyterror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (must attack)
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK,aux.AND(aux.SelfTappedCondition,aux.TurnPlayerCondition(PLAYER_OPPO)),0,LOCATION_BZONE)
end
