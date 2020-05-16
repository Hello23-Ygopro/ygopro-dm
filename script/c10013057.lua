--悪魔聖霊アウゼス
--Auzesu, the Demonic Holy Spirit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND,RACE_DEMON_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--sympathy (angel command, demon command)
	aux.EnableSympathy(c,RACE_ANGEL_COMMAND,RACE_DEMON_COMMAND)
	--destroy
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--destroy
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:DMIsRace(RACE_ANGEL_COMMAND,RACE_DEMON_COMMAND)
end
function scard.desfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
scard.op1=aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1)
