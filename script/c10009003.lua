--Azaghast, Tyrant of Shadows
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DARK_LORD))
	--destroy
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
scard.evolution_race_list={RACE_DARK_LORD}
--destroy
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp and c:DMIsRace(RACE_GHOST)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.desfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1,1,HINTMSG_DESTROY)
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
--[[
	Notes
	* This card's effect is different in the OCG.
]]
