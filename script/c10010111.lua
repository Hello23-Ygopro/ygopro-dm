--Elixia, Pureblade Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con2)
	aux.AddEffectDescription(c,1,scard.con2)
end
--power up
function scard.val1(e,c)
	local g=Duel.GetMatchingGroup(aux.ManaZoneFilter(),c:GetControler(),LOCATION_MZONE,0,nil)
	local ct=g:GetClassCount(Card.GetCivilization)
	return ct*3000
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
--triple breaker
function scard.con2(e)
	return e:GetHandler():IsPowerAbove(15000)
end
--[[
	References
		1. Performapal Dramatic Theater
		https://github.com/Fluorohydride/ygopro-scripts/blob/d35f462/c55553602.lua#L32
]]
