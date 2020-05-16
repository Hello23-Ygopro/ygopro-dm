--Gregoria, Princess of War
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	aux.AddNameCategory(c,NAMECAT_PRIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.DMIsRace,RACE_DEMON_COMMAND))
	--get ability (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.DMIsRace,RACE_DEMON_COMMAND))
end
--[[
	Notes
		* "Princess" is a word that can cause creatures to become "Prin" creatures
		https://duelmasters.fandom.com/wiki/Prin
]]
