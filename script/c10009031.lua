--Necrodragon Izorist Vhal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
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
	return Duel.GetMatchingGroupCount(aux.DMGraveFilter(Card.IsCivilization),c:GetControler(),LOCATION_GRAVE,0,nil,CIVILIZATION_DARKNESS)*2000
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
