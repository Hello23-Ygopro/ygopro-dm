--ゼリーム・クロウラー
--Zereem Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack untapped
	aux.EnableAttackUntapped(c,CIVILIZATION_FIRE)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
