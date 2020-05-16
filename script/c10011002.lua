--Heavyweight Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap ability (destroy)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap ability (destroy)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1,2,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	local pwr=g:GetSum(Card.GetPower)
	if pwr<e:GetHandler():GetPower() then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
