(in-package #:erinome-native)

(define-action sign (json-object)
  (let ((text (jsown:val json-object "text"))
	(temp-to-sign-file (random-path))
	(temp-signed-file (random-path)))
    (delete-files (list temp-to-sign-file temp-signed-file))
    (write-file temp-to-sign-file text)
    (sign-run-gpg temp-to-sign-file temp-signed-file)
    (jsown:new-js
     ("action" "signed")
     ("id" (jsown:val json-object "id"))
     ("text" (read-file temp-signed-file)))))

(defun sign-run-gpg (temp-to-sign-file temp-signed-file)
  (external-program:run
   "/usr/bin/gpg"
   (list
    "--output" temp-signed-file
    "--clearsign" temp-to-sign-file)))
