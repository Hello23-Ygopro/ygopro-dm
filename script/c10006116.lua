--Phantasmal Horror Gigazald
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CHIMERA))
	--get ability (tap ability - discard)
	aux.AddStaticEffectTapAbility(c,0,scard.tg1,scard.op1,LOCATION_BZONE,0,scard.tg2)
end
scard.evolution_race_list={RACE_CHIMERA}
--get ability (tap ability - discard)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1,1,true)
scard.tg2=aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATION_DARKNESS)
