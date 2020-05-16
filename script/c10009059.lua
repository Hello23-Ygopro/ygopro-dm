--Magmadragon Ogrist Vhal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOLCANO_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con2)
	aux.AddEffectDescription(c,1,scard.con2)
end
--power up
function scard.val1(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*3000
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
--triple breaker
function scard.con2(e)
	return e:GetHandler():IsPowerAbove(15000)
end
