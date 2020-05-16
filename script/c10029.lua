--ボルブレイズ・ドラゴン
--Bolblaze Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--to grave (mana)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	--to grave (shield)
	aux.AddTriggerEffect(c,1,EVENT_CUSTOM+EVENT_BREAK_SHIELD,true,scard.tg2,scard.op2,nil,scard.con1)
	--attack untapped
	aux.EnableAttackUntapped(c)
end
--to grave (mana)
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(Card.DMIsAbleToGrave),0,LOCATION_MZONE)
scard.op1=aux.SendtoGraveOperation(PLAYER_OPPO,aux.ManaZoneFilter(),0,LOCATION_MZONE,1)
--to grave (shield)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.DMIsAbleToGrave,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return re:GetHandler()==e:GetHandler() and g:GetCount()>0
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=e:GetLabelObject()
	for tc in aux.Next(g) do
		--chain limit
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1,true)
	end
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.DMSendtoGrave(e:GetLabelObject(),REASON_EFFECT)
end
