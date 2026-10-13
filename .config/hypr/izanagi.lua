hl.monitor({
	output = "eDP-1",
	mode = "1920x1200@60",
	position = "0x0",
	scale = "1",
})

require("volume")(5)

local run_script = require("lib/script")

hl.bind("XF86AudioMicMute", run_script("microphone.sh", "toggle"), { locked = true })

hl.bind("XF86MonBrightnessUp", run_script("brightness.sh", "up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", run_script("brightness.sh", "down"), { locked = true, repeating = true })
