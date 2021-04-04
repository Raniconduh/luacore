#!/usr/bin/env lua

function stdin_cat()
	for line in io.lines() do print(line) end
end

if #arg < 1 then
	stdin_cat()
	os.exit()
end

function cat(file_name)
	-- cat stdin if file if "-"
	if file_name == "-" then stdin_cat() return end

	file = io.open(file_name, "r")
	if not file then print("cat: "..file_name..": No such file or directory") return end
	
	-- cat an actual file
	for line in file:lines() do
		io.write(line.."\n")
	end
	file:close()
end


to_cat = {}

function help()
	print("Usage: cat [file]...")
	print("Concatenate files to stdout")
	print("if no file or file is '-' then read from stdin")
	print("\nExample: cat file.c - second_file")
	print("The example will cat file.c first, then stdin, then second_file")
end

-- loop through arguments and cat them all
for i = 1, #arg do
	if arg[i] == "-h" or arg[i] == "--help" then
		help()
		os.exit(0)
	else
		table.insert(to_cat, arg[i])
	end
end


for i = 1, #to_cat do
	cat(to_cat[i])
end

