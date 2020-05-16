--Crath Lade, Merciless King
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (discard)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (discard)
scard.tg1=aux.CheckCardFunction(aux.TRUE,0,LOCATION_HAND)
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,2,2,true)
