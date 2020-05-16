--Megaria, Empress of Dread
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (slayer)
	aux.AddStaticEffectSlayer(c,LOCATION_BZONE,LOCATION_BZONE)
end
