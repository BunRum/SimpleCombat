module main
import os
// import fs



fn main() {
	rec(os.getwd())
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
		println(name)
		if os.is_dir(name) {
			combine(mut files, rec(name))
			// println(directory)
		}
	}
	return files
}