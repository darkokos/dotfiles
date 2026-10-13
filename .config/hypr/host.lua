local f = assert(io.open("/etc/hostname", "r"))
local name = f:read("*l")
f:close()
if not name or name == "" then
	error("/etc/hostname is empty", 2)
end

return name
