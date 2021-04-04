#!/usr/bin/env lua
local dirent = require 'posix.dirent'

-- command line flags
all = false			-- list all
almost_all = false	-- list everything but '.' and '..'
sep_lines = false	-- list each entry on a seperate line

listed = false

function ls(dir_name)
	listed = true
	
	if sep_lines then ending = "\n" else ending = "   " end

	entries = dirent.dir(dir_name)
	table.sort(entries)
	j = 1
	for k = 1, #entries do
		entry = entries[k]
		if entry:sub(1, 1) == "." then
			if all then
				io.write(entry..ending)
				j = j + 1
			elseif almost_all and entry ~= "." and entry ~= ".." then
				io.write(entry..ending)
				j = j + 1
			end
		else
			io.write(entry..ending)
			j = j + 1
		end
		if j % 5 == 0 and not sep_lines then io.write("\n") end
	end
	if not sep_lines and j % 5 ~= 0 then io.write("\n") end
end


-- list current directory if no arguments
if #arg < 1 then
	ls(".")
	os.exit()
end


function help()
	print("Usage: ls [-1Aal] [directory]")
	print("Display the contents of the specified directory or the current directory if not specified")
	print("Options:")
	print("  -1    display 1 file per line")
	print("  -a    display all files in directory")
	print("  -A    display almost all files in directory. The same as -a but will not list '.' and '..'")
	print("  -l    the same as -1")
end


-- names of directories that need to be listed
dirs_to_list = {}


-- handle arguments
for i = 1, #arg do
	argument = arg[i]
	if argument == "--help" then
		help()
		os.exit(0)
	end
	if argument:sub(1,1) == '-' then
		for i = 2, #argument do
			arg_letter = argument:sub(i, i)
			-- show all files
			if arg_letter == 'a' then
				if almost_all == true then
					io.stderr:write("ls: conflicting arguments a and A\n")
					os.exit(1)
				else
					all = true
				end
			-- show all files but '.' and '..'
			elseif arg_letter == 'A' then
				if all == true then
					io.stderr:write("ls: conflicting arguments a and A\n")
					os.exit(1)
				else
					almost_all = true
				end
			-- list entry per line
			elseif arg_letter == 'l' or arg_letter == "1" then
				sep_lines = true
			-- invalid argument
			else
				io.stderr:write("ls: invalid argument -- "..arg_letter.."\n")
				os.exit(1)
			end
		end
	else
		table.insert(dirs_to_list, argument)
	end
end


for i = 1, #dirs_to_list do
	ls(dirs_to_list[i])
end

if not listed then
	ls(".")
end

