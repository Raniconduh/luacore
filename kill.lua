#!/usr/bin/env lua

function help()
	print("Usage: kill [-signal] <pid>")
	print("Send the specified signal to the specified pid")
end

if #arg < 1 then
	help()
	os.exit(1)
end


local signal = require("posix.signal")

-- only one argument -- the PID
if #arg == 1 then
	pid = tonumber(arg[1])
	if not pid or arg[1]:sub(1, 1) == "-" then
		io.stderr:write("kill: "..arg[1]..": Not a valid pid\n")
		os.exit(1)
	end

	if not signal.kill(pid, signal.SIGTERM) then
		io.stderr:write("kill: "..pid..": Could not be killed\n")
		os.exit(1)
	end
-- multiple arguments
-- may be the signal and PID(s)
else
	sig_to_send = signal.SIGTERM
	-- figure out the given signal
	if arg[1]:sub(1, 1) == "-" then
		sig_name = tonumber(arg[1]:sub(2, #arg[1]))
		if sig_name then
			sig_to_send = sig_name
		else
			io.stderr:write("kill: "..arg[1]..": Invalid signal\n")
			os.exit(1)
		end
	end
	
	-- send signal to all the arguments
	for argument = 2, #arg do
		pid = tonumber(arg[argument])
		if not pid then
			io.stderr:write("kill: "..arg[arguments]..": Invalid pid")
			os.exit(1)
		end
		if not signal.kill(pid, sig_to_send) then
			io.stderr:write("kill: "..pid..": Could not be killed\n")
		end
	end
end

