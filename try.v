module main
import os
// import fs



fn main() {
	rec(os.home_dir())
	// print(rec("./"))
}

fn combine(mut tbl1 []string, tbl2 []string) {
	for variable in tbl2 {
		tbl1.insert(tbl1.len, variable)
	}
}

fn rec(dir string) []string  {
	mut files := os.ls(dir) or {[]}
	// println(files)
	for directory in files {
		name := '${dir}/${directory}'
		println(name)
		if os.is_dir(name) {
			combine(mut files, rec(directory))
			// println(directory)
		}
	}
	return files
}