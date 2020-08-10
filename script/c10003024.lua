--Bone Piercer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1)
end
--return
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(scard.thfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(Card.IsCreature),LOCATION_MZONE,0,1)
