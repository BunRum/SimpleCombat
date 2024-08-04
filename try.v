module main
import os
// import fs

fn rec(dir string) {
	returnedfiles := []string{}
	files := os.ls(dir) or {[]}
	for file in files {
		
	}
}

fn main() {
	files := os.glob() or {[]}
	print(files)
	// os.glob()
}