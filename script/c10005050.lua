--Crow Winger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATIONS_WD)
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),0,LOCATION_BZONE,nil)*1000
end
