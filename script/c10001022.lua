--Toel, Vizier of Hope
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,scard.tg1,scard.op1,nil,scard.con1)
end
--untap
scard.con1=aux.TurnPlayerCondition(PLAYER_SELF)
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
scard.tg1=aux.CheckCardFunction(scard.posfilter,LOCATION_BZONE,0)
scard.op1=aux.UntapOperation(nil,scard.posfilter,LOCATION_BZONE,0)
