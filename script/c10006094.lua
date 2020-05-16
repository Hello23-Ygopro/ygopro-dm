--Charmilia, the Enticer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (search - to hand)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (search - to hand)
scard.tg1=aux.CheckDeckFunction(PLAYER_SELF)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,Card.IsCreature,LOCATION_DECK,0,0,1,true)
