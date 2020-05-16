--Snork La, Shrine Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--return
	aux.AddTriggerEffect(c,0,EVENT_TO_GRAVE,true,scard.tg1,scard.op1,nil,scard.con1)
end
--return
function scard.cfilter(c,tp)
	return c:IsControler(tp) and aux.PreviousLocationMZoneFilter(c)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.DMGraveFilter(scard.cfilter),1,nil,tp) and rp==1-tp
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(Card.IsAbleToMZone,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoMZone(eg,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
