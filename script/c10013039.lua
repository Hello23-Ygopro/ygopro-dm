--パルピィ・ゴービー
--Pulpy Goobie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--sort
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SortDecktopOperation(PLAYER_SELF,PLAYER_SELF,5))
	--cannot attack
	aux.EnableCannotAttack(c)
end
