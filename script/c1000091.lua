--Neve, the Leveler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--search (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--search (to hand)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	local ct2=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	return ct1>ct2
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	local ct2=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	local ct=ct1-ct2
	if ct<=0 then return end
	aux.SendtoHandOperation(PLAYER_SELF,Card.IsCreature,LOCATION_DECK,0,0,ct,true)(e,tp,eg,ep,ev,re,r,rp)
end
