--Bakkra Horn, the Silent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1),nil,scard.con1)
end
--to mana zone
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp
		and (c:DMIsRace(RACE_DRAGO_NOID) or c:IsRaceCategory(RACECAT_DRAGON))
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
