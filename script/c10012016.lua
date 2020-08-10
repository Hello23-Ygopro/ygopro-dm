--Agira, the Warlord Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR,RACE_EARTH_EATER)
	aux.AddEvolutionRaceList(c,RACE_GLADIATOR,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GLADIATOR,RACE_EARTH_EATER))
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_GLADIATOR,RACE_EARTH_EATER))
	--draw
	aux.AddTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
end
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_GLADIATOR,RACE_EARTH_EATER)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil)
end
