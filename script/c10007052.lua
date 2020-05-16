--Popple, Flowerpetal Dancer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (to mana zone)
	aux.EnableTapAbility(c,0,aux.DecktopSendtoMZoneTarget(PLAYER_SELF),aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1))
end
