--Enchanted Soil
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(PLAYER_SELF,aux.DMGraveFilter(Card.IsCreature),LOCATION_GRAVE,0,0,2))
end
