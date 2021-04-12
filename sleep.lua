#!/usr/bin/env lua

function help()
	print("Usage: sleep TIME")
	print("Sleep for the specified tine")
end

if #arg < 1 then
	help()
	os.exit(1)
end

count = tonumber(arg[1])
if not count then
	io.stderr:write("sleep: Invalid time")
	os.exit(1)
end

local unistd = require ("posix.unistd")
unistd.sleep(math.ceil(count))

