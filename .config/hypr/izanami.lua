hl.monitor({
	output = "DP-1",
	mode = "2560x1440@240",
	position = "0x0",
	scale = "1",
})
hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "2560x0",
	scale = "1",
})

require("volume")(2)

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2", default = true, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "DP-2", persistent = true })
