--Lamiel, Destiny Enforcer
--Not fully implemented: If this and another creature are destroyed at the same time, you can still trigger its ability.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (draw)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.AddTriggerEffect(c,0,EVENT_DESTROYED,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,aux.AND(aux.WaveStrikerCondition,scard.con1))
end
--wave striker (draw)
function scard.cfilter(c,tp)
	return c:IsCreature() and c:GetPreviousControler()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp) and Duel.GetTurnPlayer()~=tp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
