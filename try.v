module main
import os
// import fs



fn main() {
	fn combine(tbl1 []any, tbl2 []any) {
	for variable in tbl2 {
		tbl1.insert(tbl1.len, variable)
	}
}

fn rec(dir string) []string{}  {
	files := os.ls(dir) or {[]}
	for directory in files {
		if os.is_dir(directory) {
			combine(files, rec(directory))
		}
	}
	return files
}

	print(rec("./"))
}
