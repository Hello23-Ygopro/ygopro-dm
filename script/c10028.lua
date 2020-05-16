--黒神龍ガルバロス
--Necrodragon Galbalos
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--choose one (to grave or discard or destroy)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1)
end
--choose one (to grave or discard or destroy)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(aux.ShieldZoneFilter(Card.DMIsAbleToGrave),tp,0,LOCATION_SZONE,1,nil)
	local b2=Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND,1,nil)
	local b3=Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_BZONE,1,nil)
	if chk==0 then return b1 or b2 or b3 end
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	if b3 then
		table.insert(option_list,aux.Stringid(sid,3))
		table.insert(t,3)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.DMIsAbleToGrave),tp,0,LOCATION_SZONE,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		Duel.DMSendtoGrave(g,REASON_EFFECT)
	elseif opt==2 then
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT)
	elseif opt==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_BZONE,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
