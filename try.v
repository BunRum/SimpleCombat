module main
import os
// import fs



fn main() {
	print(rec("./src/characters"))
}

fn combine(mut tbl1 []string, tbl2 []string) {
	for variable in tbl2 {
		tbl1.insert(tbl1.len, variable)
	}
}

fn rec(dir string) []string  {
	mut files := []string{}
	// println(files)
	for directory in os.ls(dir) or {[]} {
		name := '${dir}/${directory}'
		if os.is_dir(name) {
			combine(mut files, rec(name))
		} else {
			files << directory
		}
	}
	return files
}