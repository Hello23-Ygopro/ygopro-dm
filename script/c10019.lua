--刹那の影ハカナゲ
--Hanakage, Shadow of Transience
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.EnableBattleWinSelfDestroy(c,0,true)
end
