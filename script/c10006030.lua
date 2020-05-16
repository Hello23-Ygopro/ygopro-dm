--Yuluk, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--summon limit
	aux.EnableEffectCustom(c,EFFECT_CANNOT_SUMMON_CREATURE,scard.con1)
	Duel.AddCustomActivityCounter(sid,ACTIVITY_CHAIN,scard.chainfilter)
end
--summon limit
function scard.chainfilter(re,tp,cid)
	return not re:IsActiveType(TYPE_SPELL)
end
function scard.con1(e)
	return Duel.GetCustomActivityCount(sid,e:GetHandlerPlayer(),ACTIVITY_CHAIN)==0
end
