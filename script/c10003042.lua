--Snip Striker Bullraizer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,scard.con1)
end
--cannot attack
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	local ct1=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	return ct2>ct1
end
