--宣凶師ドロシア
--Dorothea, the Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_DISCARD,nil,nil,scard.op1,nil,scard.con1)
end
--draw
scard.con1=aux.AND(aux.EventPlayerCondition(PLAYER_SELF),aux.TurnPlayerCondition(PLAYER_OPPO))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
