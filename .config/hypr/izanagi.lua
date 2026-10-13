hl.monitor({
	output = "eDP-1",
	mode = "1920x1200@60",
	position = "0x0",
	scale = "1",
})

require("volume")(5)

local run_script = require("lib/script")

hl.bind("XF86AudioMicMute", run_script("microphone.sh", "toggle"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
