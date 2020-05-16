--Alcadeias, Lord of Spirits
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	aux.AddNameCategory(c,NAMECAT_LORD_OF_SPIRITS)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ANGEL_COMMAND))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot cast
	aux.EnablePlayerEffectCustom(c,EFFECT_CANNOT_ACTIVATE,1,1,scard.val1)
end
scard.evolution_race_list={RACE_ANGEL_COMMAND}
scard.evolution_race_cat_list={RACECAT_COMMAND}
--cannot cast
function scard.val1(e,re,tp)
	local rc=re:GetHandler()
	return rc:IsSpell() and not rc:IsCivilization(CIVILIZATION_LIGHT)
end
