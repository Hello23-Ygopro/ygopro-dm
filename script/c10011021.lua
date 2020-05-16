--Squawking Lunatron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_MOON)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (return)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (return)
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(Card.IsAbleToHand),LOCATION_MZONE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(),LOCATION_MZONE,0,1,3)
