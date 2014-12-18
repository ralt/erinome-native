:#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(ql:quickload "pgp-ext-app")

(sb-ext:save-lisp-and-die #P"dist/pgp-ext-app"
                          :toplevel 'pgp-ext-app:main
                          :executable t
                          :purify t)
