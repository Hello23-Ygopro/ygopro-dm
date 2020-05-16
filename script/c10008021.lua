--Lalicious
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm hand, deck
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--confirm hand, deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.NOT(Card.IsPublic),tp,0,LOCATION_HAND,1,nil)
		or Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.NOT(Card.IsPublic),tp,0,LOCATION_HAND,nil)
	local g2=Duel.GetDecktopGroup(1-tp,1)
	if g1:GetCount()>0 then
		Duel.ConfirmCards(tp,g1)
	end
	if g2:GetCount()>0 then
		Duel.ConfirmCards(tp,g2)
	end
end
