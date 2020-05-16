--吸引のシーリゲル
--Sirigel, the Absorber
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--return
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,1,nil)
		or Duel.IsExistingMatchingCard(aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,nil)
	if g1:GetCount()==0 and g2:GetCount()==0 then return end
	local option_list={}
	local t={}
	if g1:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if g2:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local g=(opt==1 and g1) or (opt==2 and g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	if opt==1 then Duel.ConfirmCards(1-tp,sg) end
end
