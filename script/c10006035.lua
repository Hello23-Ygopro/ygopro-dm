--King Triumphant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.PlayerSummonCreatureCondition(PLAYER_OPPO))
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_OPPO,nil,nil,nil,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--blocker
	aux.AddTempEffectBlocker(c,c,1)
end
