--World Tree, Root of Life
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_TREE_FOLK))
	--power attacker
	aux.EnablePowerAttacker(c,2000)
	--stealth (darkness)
	aux.EnableStealth(c,CIVILIZATION_DARKNESS)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
scard.evolution_race_list={RACE_TREE_FOLK}
