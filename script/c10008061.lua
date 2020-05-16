--スケルトン･バイス
--Skeleton Vice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--discard
	aux.AddSpellCastEffect(c,0,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,2,2,true))
end
