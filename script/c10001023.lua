--Aqua Hulcus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
