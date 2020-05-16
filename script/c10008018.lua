--Eureka Charger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--draw
	aux.AddSpellCastEffect(c,0,nil,aux.DrawOperation(PLAYER_SELF,1))
	--charger
	aux.EnableEffectCustom(c,EFFECT_CHARGER)
end
