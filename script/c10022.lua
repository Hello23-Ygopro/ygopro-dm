--火焔漁師ガンゾ
--Ganzo, Flame Fisherman
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--wins all battles (liquid people)
	aux.EnableWinsAllBattles(c,0,aux.FilterBoolFunction(Card.DMIsRace,RACE_LIQUID_PEOPLE))
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--return
	aux.EnableTurnEndSelfReturn(c,1)
end
