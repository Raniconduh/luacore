#!/usr/bin/env lua
if #arg < 2 then
	io.stderr:write("cp: not enough arguments given")
	io.stderr:write("usage: cp source destination")
	os.exit(1)
end

-- open source file
source = io.open(arg[1], "rb")
-- verify source file can be opened
if not source then
	io.stderr:write("cp: cannot open source file '"..arg[1].."' for reading")
	os.exit(1)
end

-- open destination file
dest = io.open(arg[2], "wb")
-- verify destination file can be opened
if not dest then
	io.stderr:write("cp: cannot open destination file '"..arg[2].."' for writing")
	os.exit(1)
end

-- copy source to destination
repeat
	buf = source:read(1024)
	if buf then dest:write(buf)
	else dest:write("") end
until not source:read(0)
source:close()
dest:close()

