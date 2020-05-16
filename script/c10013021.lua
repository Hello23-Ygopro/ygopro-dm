--予言者ポラリス
--Polaris, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_BE_BATTLE_TARGET,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc:IsFaceup() and tc:IsControler(tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() or not tc:IsRelateToBattle() or not tc:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,tc,1,2000,0,0)
end
