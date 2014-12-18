all:
	mkdir -p dist; sbcl --script save-image.lisp
