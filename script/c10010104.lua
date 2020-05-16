--Ulex, the Dauntless
--Not fully implemented: SetValue doesn't work to only prevent the opponent from tapping it.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot tap
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POS_E)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	--Note: Remove aux.NOT(aux.SelfAttackerCondition) if SetValue works
	e1:SetCondition(aux.AND(aux.SelfUntappedCondition,aux.NOT(aux.SelfAttackerCondition)))
	--e1:SetValue(scard.abfilter)
	c:RegisterEffect(e1)
end
--cannot tap
function scard.abfilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
