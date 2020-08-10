--Grave Worm Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (return)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	aux.AddSingleGrantTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,nil,LOCATION_ALL,0,scard.tg2)
end
--survivor (return)
function scard.thfilter(c)
	return c:DMIsRace(RACE_SURVIVOR) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.DMGraveFilter(scard.thfilter),tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0,1)
scard.tg2=aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR)
