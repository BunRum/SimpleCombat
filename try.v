module main
import os
// import fs

fn main() {
	files := os.ls("./") or {[]}
	print(os.ls("./") or {[]})
}