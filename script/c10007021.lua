--Garatyano
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (confirm deck)
	aux.EnableTapAbility(c,0,aux.CheckDeckFunction(PLAYER_SELF),aux.SortDecktopOperation(PLAYER_SELF,PLAYER_SELF,3))
end
