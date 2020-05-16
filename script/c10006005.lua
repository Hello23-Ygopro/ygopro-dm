--Invincible Abyss
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,aux.DestroyOperation(nil,Card.IsFaceup,0,LOCATION_BZONE))
end
