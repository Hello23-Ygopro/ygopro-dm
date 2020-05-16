--Sky Crusher, the Agitator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (to grave)
	aux.EnableTapAbility(c,0,aux.CheckCardFunction(aux.ManaZoneFilter(Card.DMIsAbleToGrave),LOCATION_MZONE,LOCATION_MZONE),scard.op1)
end
--tap ability (to grave)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	aux.SendtoGraveOperation(PLAYER_SELF,aux.ManaZoneFilter(),LOCATION_MZONE,0,1)(e,tp,eg,ep,ev,re,r,rp)
	aux.SendtoGraveOperation(PLAYER_OPPO,aux.ManaZoneFilter(),0,LOCATION_MZONE,1)(e,tp,eg,ep,ev,re,r,rp)
end
