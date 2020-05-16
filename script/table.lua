--find a particular item in a list
function table.find(t,el)
	for i,v in pairs(t) do
		if v==el then
			return i
		end
	end
end
