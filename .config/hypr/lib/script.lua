local HYPR = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr"

local function quote(string)
	return "'" .. tostring(string):gsub("'", "'\\''") .. "'"
end

return function(name, args)
	local cmd = "bash " .. quote(HYPR .. "/scripts/" .. name)
	if type(args) == "table" then
		for _, arg in ipairs(args) do
			cmd = cmd .. " " .. quote(arg)
		end
	elseif args then
		cmd = cmd .. " " .. args
	end

	return hl.dsp.exec_cmd(cmd)
end
