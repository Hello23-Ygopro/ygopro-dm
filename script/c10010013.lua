--Clearlo, Grace Enforcer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,0,c)*1000
end
