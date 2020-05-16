--Cryptic Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot use shield trigger
	aux.EnablePlayerEffectCustom(c,EFFECT_CANNOT_ACTIVATE,0,1,scard.val1,aux.SelfTappedCondition)
end
--cannot use shield trigger
function scard.val1(e,re,tp)
	return re:IsHasCategory(CATEGORY_SHIELD_TRIGGER) and re:GetHandler():IsBrokenShield()
end
