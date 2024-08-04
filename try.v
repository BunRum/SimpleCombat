module main
import os
// import fs



fn main() {
	
	for file in rec("./src/characters") {
		directory := file.all_before_last("/")
		filename := file.after("/").all_before(".")
		if os.file_ext(file) == ".luau" {
			os.write_file_array('${directory}/${filename}.meta.json', '{"properties":{"RunContext":"Server"}}'.bytes())!
		}
	}
	for {
		mut savedlen := 0
		if savedlen < rec("./src/characters").len {
			files := rec("./src/characters")
			savedlen = files.len
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
	// println(files)
	for directory in os.ls(dir) or {[]} {
		name := '${dir}/${directory}'
		// name := directory
		if os.is_dir(name) {
			combine(mut files, rec(name))
		} else {
		
			files << name
		}
	}
	return files
}