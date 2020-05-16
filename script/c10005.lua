--ガルベリアス・ドラゴン
--Galberius Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1(CIVILIZATION_NATURE))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,nil,scard.con1(CIVILIZATION_WATER))
	aux.AddEffectDescription(c,2,scard.con1(CIVILIZATION_WATER))
	--slayer
	aux.EnableSlayer(c,scard.con1(CIVILIZATION_DARKNESS))
	aux.AddEffectDescription(c,3,scard.con1(CIVILIZATION_DARKNESS))
	--untap
	aux.EnableTurnEndSelfUntap(c,1,scard.con1(CIVILIZATION_LIGHT))
end
--to mana zone
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
function scard.cfilter(c,civ)
	return c:IsFaceup() and c:IsCivilization(civ)
end
function scard.con1(civ)
	return	function(e)
				return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),0,LOCATION_BZONE,1,nil,civ)
			end
end
