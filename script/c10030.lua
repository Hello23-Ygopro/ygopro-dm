--緑神龍ハルクーンベルガ
--Terradragon Hulcoon Berga
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (power attacker)
	aux.AddStaticEffectPowerAttacker(c,4000,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(),aux.SelfTappedCondition)
	--get ability (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.SelfTappedCondition,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
	--get ability
	aux.AddTriggerEffect(c,1,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,aux.SelfTappedCondition)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,2,scard.con1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con2)
	aux.AddEffectDescription(c,3,scard.con2)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local os=require('os')
	math.randomseed(os.time())
	local t={1000,2000,3000,4000,5000}
	local val=t[math.random(#t)]
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,val,0,0)
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
--triple breaker
function scard.con2(e)
	return e:GetHandler():IsPowerAbove(9000)
end
--[[
	Notes
	* The possible increase amount of this card in the game is 1000 to 5000 per turn.
	https://duelmasters.fandom.com/wiki/Terradragon_Hulcoon_Berga#Notes
]]
