local fs = require("@lune/fs")
local serde = require("@lune/serde")
local task = require("@lune/task")
local process = require("@lune/process")

function combineTables(table1, table2)
	local newtable = {}
	for _, v in pairs(table1) do
		table.insert(newtable, v)
	end
	for _, v in pairs(table2) do
		table.insert(newtable, v)
	end
	return newtable
end

function getallFiles(dir)
	local function rec(d)
		local files = {}
		for _, v in pairs(fs.readDir(d)) do
			local newname = `{d}/{v}`
			if fs.isDir(newname) then
				files = combineTables(files, rec(newname))
			else
				table.insert(files, newname)
			end
		end
		return files
	end

	return (rec(dir))
end

function getfilename(path: string): string
	local function rec(p): string
		local i = string.find(p, "/")
		if i > 0 then
			p = string.sub(p, i + 1, string.len(p))
			if string.match(p, "/") then
				p = rec(p)
			end
		end
		return p
	end

	return rec(path)
end

local function getpath(f: string)
	return string.gsub(f, `/{getfilename(f)}`, "")
end

function getfileinfo(file: string)
	return {
		name = getfilename(file),
		path = getpath(file),
	}
end

function redo()
	for _, file in pairs(getallFiles("src/characters")) do
		local fileinfo = getfileinfo(file)

		if string.match(file, ".server.luau") then
			local servername = string.gsub(fileinfo.name, ".server.luau", "")
			local json = `{fileinfo.path}/{servername}.meta.json`
			if not fs.isFile(json) then
				fs.writeFile(
					json,
					serde.encode("json", {
						properties = {
							RunContext = "Server",
						},
					})
				)
			end
		end
	end

	process.spawn("rojo", {
		"sourcemap",
		"-o",
		"sourcemap.json",
	})

	print("made all")
end

-- task.spawn(function()
-- 	local asd = process.spawn("rojo", {
-- 		"serve",
-- 		"default.project.json"
-- 	}, {
-- 		stdio = {
-- 			stdout = "forward"
-- 		}
-- 	})
-- end)

redo()
local last = getallFiles("src")

while true do
	task.wait()
	local newfiles = getallFiles("src")
	if #newfiles ~= #last then
		print("change detected")
		if #newfiles < #last then
			print("file deleted")
		elseif #newfiles > #last then
			print("new file")
		end
		redo()
		last = getallFiles("src")
	else
		last = newfiles
	end
end
