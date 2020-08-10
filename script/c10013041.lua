--マジカル・ポット
--Magical Pot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_SELF,scard.thfilter,LOCATION_BZONE,LOCATION_BZONE,1))
end
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
