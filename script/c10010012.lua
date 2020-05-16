--Bulgluf, the Spydroid
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SOLTROOPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (to shield zone)
	aux.EnableSilentSkill(c,0,aux.DecktopSendtoSZoneTarget(PLAYER_SELF),aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1))
end
