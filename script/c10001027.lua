--Brain Serum
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddNameCategory(c,NAMECAT_BRAIN)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--draw
	aux.AddSpellCastEffect(c,0,nil,aux.DrawUpToOperation(PLAYER_SELF,2))
end
