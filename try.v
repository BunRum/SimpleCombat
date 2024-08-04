module main
import os
// import fs



fn main() {
	mut savedlen := 0
	for {
		if savedlen < rec("./src/characters").len {
			files := rec("./src/characters")
			savedlen = files.len
			for file in files {
				directory := file.all_before_last("/")
				filename := file.after("/").all_before(".")
				if os.file_ext(file) == ".luau" {
					// println("new file")
					os.write_file_array('${directory}/${filename}.meta.json', '{"properties":{"RunContext":"Server"}}'.bytes())!
				}
			}
		}
	}
}

fn combine(mut tbl1 []string, tbl2 []string) {
	for variable in tbl2 {
		tbl1.insert(tbl1.len, variable)
	}
}

fn rec(dir string) []string  {
	mut files := []string{}
	for directory in os.ls(dir) or {[]} {
		name := '${dir}/${directory}'
		if os.is_dir(name) {
			combine(mut files, rec(name))
		} else {
		
			files << name
		}
	}
	return files
}