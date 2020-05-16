--Bombazar, Dragon of Destiny
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_EARTH_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--destroy, get ability
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPower(6000)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,c)
	Duel.Destroy(g,REASON_EFFECT)
	--skip turn
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	if Duel.GetTurnPlayer()~=tp then
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
	Duel.RegisterEffect(e1,tp)
	--lose game
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(scard.con1)
	e2:SetOperation(scard.op2)
	if Duel.GetTurnPlayer()~=tp then
		e2:SetLabel(Duel.GetTurnCount()+3)
	else
		e2:SetLabel(Duel.GetTurnCount()+2)
	end
	if Duel.GetTurnPlayer()~=tp then
		e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
	else
		e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	end
	Duel.RegisterEffect(e2,tp)
end
--lose game
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetLabel()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Win(1-tp,WIN_REASON_BOMBAZAR)
end
