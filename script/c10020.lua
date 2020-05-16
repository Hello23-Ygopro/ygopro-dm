--冥妃アイオリア
--Aioria, Dark Princess
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (destroy)
	aux.EnableTapAbility(c,0,nil,aux.DestroyOperation(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,true))
end
--[[
	Notes
		* This card's Japanese name does not include プリン ("Prin")
		https://duelmasters.fandom.com/wiki/Aioria,_Dark_Princess
]]
