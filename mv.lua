#!/usr/bin/env lua
function help()
	print("Usage: mv source... destination")
	print("If the destination is a directory and multiple source files are given or the source file is not a directory, move the source files into that directory")
	print("Otherwise move the source file to the specified location")
end

if #arg < 2 then
	help()
	os.exit(1)
end
local sys_stat = require("posix.sys.stat")


function is_dir(path)
	f = sys_stat.lstat(path)
	if f then
		return sys_stat.S_ISDIR(f.st_mode)
	end
	return nil
end


function exists(path)
	return sys_stat.lstat(path)
end


-- whether or not output is a directory
copy_to_dir = false
if is_dir(arg[#arg]) then
	copy_to_dir = true
end

if #arg > 2 and not is_dir(arg[#arg]) then
	io.stderr:write("mv: "..arg[#arg]..": not a directory\n")
	os.exit(1)
end

-- move all arguments
for i = 1, #arg - 1 do
	if arg[i] == "-h" or arg[i] == "--help" then
		help()
		os.exit(0)
	end
	if not exists(arg[i]) then
		io.stderr:write("mv: "..arg[i]..": no such file or directory\n")
		goto continue -- go to top of loop - this file doesn't exist
	end
	
	if copy_to_dir then
		os.rename(arg[i], arg[#arg].."/"..arg[i])
	else
		os.rename(arg[i], arg[#arg])
	end
	::continue::
end

