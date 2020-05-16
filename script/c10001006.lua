--Holy Awe
--ホーリー・スパーク (Holy Spark)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddNameCategory(c,NAMECAT_HOLY_SPARK)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--tap
	aux.AddSpellCastEffect(c,0,nil,aux.TapOperation(nil,Card.IsFaceup,0,LOCATION_BZONE))
end
