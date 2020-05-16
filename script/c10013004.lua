--霊樹海嶺ガウルザガンタ
--Gaulzaganta, Spirit of the Woodland Ridges
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--sympathy (gel fish, snow faerie)
	aux.EnableSympathy(c,RACE_GEL_FISH,RACE_SNOW_FAERIE)
	--tap
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--tap
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil)
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsEvolution() and c:IsUntapped()
end
scard.op1=aux.TapOperation(nil,scard.posfilter,LOCATION_BZONE,LOCATION_BZONE)
