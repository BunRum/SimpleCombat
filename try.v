module main
import os
// import fs



fn main() {

	print(rec("./"))
}

fn combine(mut tbl1, tbl2) {
	for variable in tbl2 {
		tbl1.insert(tbl1.len, variable)
	}
}

fn rec(dir string) []string  {
	mut files := os.ls(dir) or {[]}
	for directory in files {
		if os.is_dir(directory) {
			combine(files, rec(directory))
		}
	}
	return files
}