--Living Citadel Vosh
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_COLONY_BEETLE))
	--get ability (tap ability - to mana zone)
	aux.AddStaticEffectTapAbility(c,0,scard.tg1,scard.op1,LOCATION_BZONE,0,scard.tg2)
end
scard.evolution_race_list={RACE_COLONY_BEETLE}
--get ability (tap ability - to mana zone)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSendDecktoptoMZone(tp,1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
scard.tg2=aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATION_NATURE)
