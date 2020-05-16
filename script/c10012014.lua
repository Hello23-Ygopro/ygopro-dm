--Pincer Scarab
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
end
--power up
function scard.val1(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_HAND)*2000
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
