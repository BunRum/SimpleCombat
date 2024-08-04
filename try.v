module main
import os
// import fs

fn rec(dir string) {
	returnedfiles := []string{}
	files := os.ls(dir) or {[]}
	
}

fn main() {
	files := os.glob() or {[]}
	print(files)
	// os.glob()
}