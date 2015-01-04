:#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(ql:quickload "erinome-native")

(sb-ext:save-lisp-and-die #P"dist/erinome-native"
                          :toplevel 'erinome-native:main
                          :executable t
			  :compression 9
                          :purify t)
