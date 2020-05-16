--Sparkle Flower
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STARLIGHT_TREE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_LIGHT))
	aux.AddEffectDescription(c,0,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_LIGHT))
end
