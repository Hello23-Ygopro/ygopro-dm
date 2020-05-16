--Fort Megacluster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_CLUSTER)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CYBER_CLUSTER))
	--get ability (tap ability - draw)
	aux.AddStaticEffectTapAbility(c,0,scard.tg1,scard.op1,LOCATION_BZONE,0,scard.tg2)
end
scard.evolution_race_list={RACE_CYBER_CLUSTER}
scard.evolution_race_cat_list={RACECAT_CYBER}
--get ability (tap ability - draw)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
scard.op1=aux.DrawOperation(PLAYER_SELF,1)
scard.tg2=aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATION_WATER)
