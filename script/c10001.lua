--界の守護者パール・キャラス
--Pearl Carras, Barrier Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--wins all battles (human)
	aux.EnableWinsAllBattles(c,0,aux.FilterBoolFunction(Card.DMIsRace,RACE_HUMAN))
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
