--Armored Decimator Valkaizer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_HUMAN))
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.evolution_race_list={RACE_HUMAN}
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(4000)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_DESTROY)
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
--[[
	Notes
	* This card's effect is different in the OCG.
]]
