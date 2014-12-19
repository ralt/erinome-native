(in-package #:pgp-ext-app)

;;; Create a temporary file, encrypt it and output
;;; to another temporary file, and send back the
;;; last temporary file.
(defun encrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message"))
	(temp-file "/tmp/foo")
	(temp-encrypted-file "/tmp/foo.gpg"))
    (mapcar #'(lambda (file)
		(when (probe-file file)
		  (delete-file file)))
	    (list temp-file temp-encrypted-file))
    (with-open-file (file temp-file
			  :direction :output
			  :if-does-not-exist :create)
      (format file "~A" message))
    (run-gpg email temp-file temp-encrypted-file)
    (with-open-file (file temp-encrypted-file)
      (jsown:new-js
	("text" (read-file file))))))

(defun run-gpg (email temp-file temp-encrypted-file)
  (sb-ext:run-program
   "/usr/bin/gpg"
   (list
    "--encrypt"
    "--recipient" email
    "--output" temp-encrypted-file
    "--yes"
    "--armor"
    temp-file)))

(defun read-file (file)
  (format
   nil
   "~{~A~%~}"
   (loop for line = (read-line file nil)
      while line
      collect line)))
