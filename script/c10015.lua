--光器ナターリャ
--Natalia, Channeler of Suns
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_DEL_SOL)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddTriggerEffectPlayerCastSpell(c,0,nil,nil,nil,nil,aux.TapOperation(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,true))
end
