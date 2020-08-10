--Fighter Dual Fang
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	aux.AddEvolutionRaceList(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_BEAST_FOLK))
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoMZoneOperation(PLAYER_SELF,2))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
