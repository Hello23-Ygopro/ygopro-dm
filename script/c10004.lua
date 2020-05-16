--石臼男
--Millstone Man
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (search - to grave)
	aux.EnableTapAbility(c,0,nil,aux.SendtoGraveOperation(PLAYER_SELF,nil,0,LOCATION_DECK,1))
end
