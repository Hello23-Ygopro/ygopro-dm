--Lu Gila, Silver Rift Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--get ability (enter tapped)
	aux.EnableEffectCustom(c,EFFECT_ENTER_BZONE_TAPPED,nil,LOCATION_ALL,LOCATION_ALL,aux.TargetBoolFunction(Card.IsEvolution))
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
