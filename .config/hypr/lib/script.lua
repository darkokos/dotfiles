local HYPR = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr"

return function(name, args)
	local cmd = "bash '" .. HYPR .. "/scripts/" .. name .. "'"
	if args then
		cmd = cmd .. " " .. args
	end

	return hl.dsp.exec_cmd(cmd)
end
