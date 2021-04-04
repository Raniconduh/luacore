#!/usr/bin/env lua
function help()
	print("Usage: rm file...")
	print("Remove the specified file(s)")
	print("\nOptions:")
	print("  -r    Recursively remove directory")
	print("  -f    Do not show errors")
end
if #arg < 1 then
	help()
	os.exit(1)
end


local sys_stat = require("posix.sys.stat")


prog_return = 0


function is_dir(path)
	return sys_stat.S_ISDIR(sys_stat.lstat(path).st_mode) == 1
end

function exists(path)
	return sys_stat.lstat(path)
end


recursive = false
force = false


function rm(name)
	if exists(name) then
		remove_status = 0
		dir = is_dir(name)

		if dir and recursive then
			remove_status = os.remove(name)
		elseif dir and not recursive and not force then
			io.stderr:write("rm: "..name..": Cannot remove directory\n")
			prog_return = 1
		elseif not dir then
			remove_status = os.remove(name)
		end

		if not remove_status and is_dir(name) and not force then
			io.stderr:write("rm: "..name..": Directory not empty\n")
			prog_return = 1
		elseif not remove_status and not force then
			io.stderr:write("rm: "..name..": Cannot remove\n")
			prog_return = 1
		end
	elseif not force then
		io.stderr:write("rm: "..name..": No such file or directory\n")
		prog_return = 1
	end
end


to_remove = {}

-- handle arguments
for i = 1, #arg do
	if arg[i] == "-h" or arg[i] == "--help" then
		help()
		os.exit(0)
	end
	-- handle arguments
	if arg[i]:sub(1, 1) == "-" then
		for j = 2, #arg[i] do
			letter = arg[i]:sub(j, j)
			if letter == "r" then recursive = true
			elseif letter == "f" then force = true
			else
				io.stderr:write("rm: "..letter..": no such option\n")
				os.exit(1)
			end
		end
	else
		table.insert(to_remove, arg[i])
	end
end

for i = 1, #to_remove do
	rm(to_remove[i])
end

os.exit(prog_return)

