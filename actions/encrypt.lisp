(in-package #:erinome-native)

(define-action encrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message"))
	(temp-file (random-path))
	(temp-encrypted-file (random-path)))
    (delete-files (list temp-file temp-encrypted-file))
    (write-file temp-file message)
    (encrypt-run-gpg email temp-file temp-encrypted-file)
    (jsown:new-js
     ("action" "encrypted")
     ("text" (read-file temp-encrypted-file))
     ("name" (jsown:val json-object "name"))
     ("email" email))))

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
