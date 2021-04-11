#!/usr/bin/env lua

function help()
	print("Usage: seq [-s] START FINISH")
	print("Print a sequence of numbers in the range STRAT to FINISH (inclusive)")
	print("Options:")
	print("  -s SEP      Use SEP as the seperator between numbers (defaults to \\n)")
end

if #arg < 2 then
	help()
	os.exit(1)
end

seperator = '\n'
start = 0
finish = 0

if arg[1] == "-s" then
	seperator = arg[2]
	if #arg < 4 then
		io.stderr:write("seq: Not enough arguments\n")
		os.exit(1)
	end
	s = tonumber(arg[3])
	f = tonumber(arg[4])
	if not s then
		io.stderr:write("seq: "..s..": Invalid number\n")
		os.exit(1)
	elseif not f then
		io.stderr:write("seq: "..f..": Invalid number\n")
		os.exit(1)
	end
	start = s
	finish = f
else
	if #arg > 2 then
		io.stderr:write("seq: Invalid arguments\n")
		os.exit(1)
	end
	s = tonumber(arg[1])
	f = tonumber(arg[2])
	if not s or not f then
		io.stderr:write("seq: Invalid start or finish\n")
		os.exit(1)
	end
	start = s
	finish = f
end

for start = start, finish do
	io.write(start..seperator)
end

if sep ~= '\n' then
	io.write('\n')
end

