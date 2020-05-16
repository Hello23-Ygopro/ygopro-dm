--薫風妖精コートニー
--Courtney, Summer Breeze Faerie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--add civilization
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ADD_CIVILIZATION)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsMana))
	e1:SetValue(CIVILIZATION_ALL)
	c:RegisterEffect(e1)
end
