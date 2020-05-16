--Kulus, Soulshine Enforcer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1),nil,scard.con1)
end
--to mana zone
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetManaCount(1-tp)>Duel.GetManaCount(tp)
end
