--Venom Capsule
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (break)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (break)
scard.tg1=aux.CheckCardFunction(aux.ShieldZoneFilter(aux.TRUE),0,LOCATION_SZONE)
scard.op1=aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1)
