--Raging Dash-Horn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,3000,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_NATURE))
	aux.AddEffectDescription(c,0,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_NATURE))
	aux.AddEffectDescription(c,1,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_NATURE))
end
