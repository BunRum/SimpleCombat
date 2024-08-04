module main
import os
// import fs

fn main() {
	files := os.glob("./") or {[]}
	print(files)
	// os.glob()
}