#!/usr/bin/env lua

alen = #arg
if alen < 1 then
	io.write("\n")
	os.exit()
end

for i = 1, alen do
	io.write(arg[i])
	if i ~= alen then io.write(" ") end
end

io.write("\n")

