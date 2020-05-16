--Fu Reil, Seeker of Storms
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot use shield trigger
	aux.EnablePlayerEffectCustom(c,EFFECT_CANNOT_ACTIVATE,1,1,scard.val1)
end
--cannot use shield trigger
function scard.val1(e,re,tp)
	local rc=re:GetHandler()
	return re:IsHasCategory(CATEGORY_SHIELD_TRIGGER) and rc:IsBrokenShield()
		and rc:IsCivilization(CIVILIZATION_DARKNESS)
end
