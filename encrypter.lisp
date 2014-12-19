(in-package #:pgp-ext-app)

;;; Create a temporary file, encrypt it and output
;;; to another temporary file, and send back the
;;; last temporary file.
(defun encrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message")))
    (with-open-file (file "/tmp/foo"
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :overwrite)
      (format file "~A" message))
    (run-gpg email "/tmp/foo")
    (with-open-file (file "/tmp/foo.gpg")
      (jsown:new-js
	("encrypted_message" (format nil "~{~s~%~}" (read-file file)))))))

(defun run-gpg (email temp-file)
  (sb-ext:run-program
   "/usr/bin/gpg"
   (list
    "--encrypt"
    "--recipient" email
    "--output" (concatenate 'string temp-file ".gpg")
    "--yes"
    "--armor"
    temp-file)))

(defun read-file (file)
  (loop for line = (read-line file nil)
     while line
     collect line))
