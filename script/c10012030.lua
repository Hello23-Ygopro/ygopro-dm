--Cloned Spike-Horn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
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
	return Duel.GetMatchingGroupCount(aux.DMGraveFilter(Card.IsCode),c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil,sid)*3000
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
