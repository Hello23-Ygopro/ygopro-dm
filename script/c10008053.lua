--Senia, Orchard Avenger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--turbo rush
	aux.EnableTurboRush(c,scard.op1)
end
--turbo rush
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,5000)
	--double breaker
	aux.AddTempEffectBreaker(c,c,2,EFFECT_DOUBLE_BREAKER)
end
