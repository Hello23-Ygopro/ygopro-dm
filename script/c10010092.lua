--Sporeblast Erengi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BALLOON_MUSHROOM)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (search - to hand)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (search - to hand)
scard.tg1=aux.CheckDeckFunction(PLAYER_SELF)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,Card.IsCreature,LOCATION_DECK,0,0,1,true)
