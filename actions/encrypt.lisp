(in-package #:erinome-native)

(define-action encrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message"))
	(temp-file (concatenate 'string +tmp-folder+ (random-string +tmp-filenames-length+)))
	(temp-encrypted-file (concatenate 'string +tmp-folder+ (random-string +tmp-filenames-length+))))
    (delete-files (list temp-file temp-encrypted-file))
    (with-open-file (file temp-file
			  :direction :output
			  :if-does-not-exist :create)
      (format file "~A" message))
    (encrypt-run-gpg email temp-file temp-encrypted-file)
    (with-open-file (file temp-encrypted-file)
      (jsown:new-js
	("action" "encrypted")
	("text" (read-file file))
	("name" (jsown:val json-object "name"))
	("email" email)))))

(defun encrypt-run-gpg (email temp-file temp-encrypted-file)
  (external-program:run
   "/usr/bin/gpg"
   (list
    "--encrypt"
    "--recipient" email
    "--output" temp-encrypted-file
    "--yes"
    "--always-trust"
    "--armor"
    temp-file)))
