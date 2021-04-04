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

-- loop through arguments and cat them all
cur_file = 1
while cur_file < #arg + 1 do
	cat(arg[cur_file])
	cur_file = cur_file + 1
end

