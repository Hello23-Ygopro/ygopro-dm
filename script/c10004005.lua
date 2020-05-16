--Supporting Tulip
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (power attacker)
	aux.AddStaticEffectPowerAttacker(c,4000,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.DMIsRace,RACE_ANGEL_COMMAND))
end
