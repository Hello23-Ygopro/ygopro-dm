--放出のゲッチェル
--Getchell, the Emitter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--to shield zone or to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--to shield zone or to mana zone
scard.tg1=aux.CheckCardFunction(aux.OR(Card.IsAbleToSZone,Card.IsAbleToMZone),LOCATION_HAND,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToSZone,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToMZone,tp,LOCATION_HAND,0,nil)
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
	local desc=(opt==1 and HINTMSG_TOSZONE) or (opt==2 and HINTMSG_TOMZONE)
	local g=(opt==1 and g1) or (opt==2 and g2)
	Duel.Hint(HINT_SELECTMSG,tp,desc)
	local sg=g:Select(tp,1,1,nil)
	if opt==1 then
		Duel.SendtoSZone(sg)
	elseif opt==2 then
		Duel.SendtoMZone(sg,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
