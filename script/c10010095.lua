--Twitch Horn, the Aggressor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1,aux.SelfAttackerCondition)
end
--power up
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.ManaZoneFilter(Card.IsTapped),c:GetControler(),LOCATION_MZONE,0,nil)*2000
end
