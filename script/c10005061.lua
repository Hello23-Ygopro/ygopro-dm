--ストームジャベリン・ワイバーン
--Storm Javelin Wyvern
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--attack untapped
	aux.EnableAttackUntapped(c,CIVILIZATION_LIGHT+CIVILIZATION_WATER)
end
