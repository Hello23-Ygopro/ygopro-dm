--Armored Cannon Balbaro
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	aux.AddEvolutionRaceList(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_HUMAN))
	--power up
	aux.EnableUpdatePower(c,scard.val1,aux.SelfAttackerCondition)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_HUMAN)
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,LOCATION_BZONE,c)*2000
end
--[[
	References
	* Chthonian Alliance
	https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c46910446.lua#L43
	* Perfect Machine King
	https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c18891691.lua#L13
]]
