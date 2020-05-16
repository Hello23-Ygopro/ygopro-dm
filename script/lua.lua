--get the value type of a variable
local lua_type=type
function type(o)
	if lua_type(o)~="userdata" then return lua_type(o)
	elseif o.GetOriginalCode then return "Card"
	elseif o.KeepAlive then return "Group"
	elseif o.SetLabelObject then return "Effect"
	else return "userdata" end
end
