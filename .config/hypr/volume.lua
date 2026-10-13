local HYPR = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr"
local SCRIPT = "bash '" .. HYPR .. "/scripts/volume.sh' "

return function(step)
	assert(
		type(step) == "number" and step > 0 and step % 1 == 0,
		"volume step must be a positive whole number, got " .. tostring(step)
	)

	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(SCRIPT .. "up " .. step), { locked = true, repeating = true })
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(SCRIPT .. "down " .. step), { locked = true, repeating = true })
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd(SCRIPT .. "mute"), { locked = true })
end
