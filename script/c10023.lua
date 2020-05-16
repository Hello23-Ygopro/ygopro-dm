--ゲットのスリング
--Gett's Sling
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_XENOPARTS)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1)
end
--destroy
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local os=require('os')
	math.randomseed(os.time())
	local t={3000,4000,5000,6000}
	local pwr=t[math.random(#t)]
	e:SetLabel(pwr)
	Duel.Hint(HINT_NUMBER,0,pwr)
end
function scard.desfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerAbove(pwr)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,e:GetLabel())
	Duel.Destroy(g,REASON_EFFECT)
end
