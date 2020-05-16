--Terradragon Cusdalf
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,4000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot untap
	aux.EnablePlayerEffectCustom(c,EFFECT_PLAYER_CANNOT_UNTAP_START,1,0)
end
--[[
	Rulings
		Q: If i can't untap cards in my mana zone at the start of my turn, when can I untap?
		A: You can only untap the cards in your mana zone via a card effect (such as Bolbalzak Ex), but not at the start
		of your turn.
		https://duelmasters.fandom.com/wiki/Terradragon_Cusdalf/Rulings
]]
