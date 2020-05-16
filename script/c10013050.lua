--ピクシー・コクーン
--Pixie Cocoon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(Card.IsCreature),LOCATION_MZONE,0,1))
	--charge
	aux.EnableEffectCustom(c,EFFECT_CHARGE_TAPPED)
end
