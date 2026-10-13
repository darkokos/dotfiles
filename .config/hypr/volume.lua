local run_script = require("lib/script")

return function(step)
	assert(
		type(step) == "number" and step > 0 and step % 1 == 0,
		"volume step must be a positive whole number, got " .. tostring(step)
	)

	hl.bind("XF86AudioRaiseVolume", run_script("volume.sh", "up " .. step), { locked = true, repeating = true })
	hl.bind("XF86AudioLowerVolume", run_script("volume.sh", "down " .. step), { locked = true, repeating = true })
	hl.bind("XF86AudioMute", run_script("volume.sh", "mute"), { locked = true })
end
