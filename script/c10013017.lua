--機動聖者ミールマックス
--Mobile Saint Meermax
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--untap
	aux.EnableBattleWinSelfUntap(c)
end
