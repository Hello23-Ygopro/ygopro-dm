--Hustle Berry
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIES)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (to mana zone)
	aux.EnableSilentSkill(c,0,aux.DecktopSendtoMZoneTarget(PLAYER_SELF),aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1))
end
