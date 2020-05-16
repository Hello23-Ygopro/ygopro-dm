--Missile Soldier Ultimo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--turbo rush
	aux.EnableTurboRush(c,scard.op1)
end
--turbo rush
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--attack untapped
	aux.AddTempEffectCustom(c,c,1,EFFECT_ATTACK_UNTAPPED)
	--power attacker
	aux.AddTempEffectPowerAttacker(c,c,2,4000)
end
