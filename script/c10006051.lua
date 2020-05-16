--Bazooka Mutant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
--attack limit
function scard.val1(e,c)
	return not c:IsHasEffect(EFFECT_BLOCKER) or not c:IsFaceup()
end
