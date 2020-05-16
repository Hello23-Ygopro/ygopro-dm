--Buoyant Blowfish
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
end
--power up
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.ManaZoneFilter(Card.IsTapped),c:GetControler(),0,LOCATION_MZONE,nil)*1000
end
