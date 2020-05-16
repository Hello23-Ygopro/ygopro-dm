--Duel Masters Rules
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	Rule.RegisterRules(c)
end
