--Bubble Scarab
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard, get ability
	aux.AddTriggerEffect(c,0,EVENT_BE_BATTLE_TARGET,true,aux.CheckCardFunction(aux.TRUE,LOCATION_HAND,0),scard.op1,nil,scard.con1)
end
--discard, get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsFaceup() and tc:IsControler(tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT)==0 then return end
	--power up
	aux.AddTempEffectUpdatePower(e:GetHandler(),Duel.GetAttackTarget(),1,3000)
end
