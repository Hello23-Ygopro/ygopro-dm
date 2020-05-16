--Illusionary Merfolk
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.ExistingCardCondition(scard.cfilter))
end
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_CYBER_LORD)
end
scard.op1=aux.DrawUpToOperation(PLAYER_SELF,3)
