--Bat Doctor, Shadow of Undeath
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	local targ_func=aux.CheckCardFunction(aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0,c)
	local op_func=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(Card.IsCreature),LOCATION_GRAVE,0,1,1,true,c)
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,targ_func,op_func)
end
--return
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
