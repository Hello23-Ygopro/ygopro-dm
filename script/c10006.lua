--新緑の鉄槌
--Verdant Hammer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--wins all battles (ghost)
	aux.EnableWinsAllBattles(c,0,aux.FilterBoolFunction(Card.DMIsRace,RACE_GHOST))
	--power attacker
	aux.EnablePowerAttacker(c,2000)
end
