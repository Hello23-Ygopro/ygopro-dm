--地脈の超人
--Ground Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
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
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_BZONE,LOCATION_BZONE,nil)
	local ct=g:GetClassCount(Card.GetCivilization)
	return ct*2000
end
--double breaker
function scard.con1(e)
	return e:GetHandler():GetPower()>6000
end
