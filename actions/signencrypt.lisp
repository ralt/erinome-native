(in-package #:erinome-native)

(define-action signencrypt (json-object)
  (let ((text (jsown:val json-object "text"))
	(recipient (jsown:val json-object "recipient"))
	(temp-to-encrypt-file (random-path))
	(temp-encrypted-file (random-path)))
    (delete-files (list temp-to-encrypt-file temp-encrypted-file))
    (write-file temp-to-encrypt-file text)
    (signencrypt-run-gpg recipient temp-to-encrypt-file temp-encrypted-file)
    (jsown:new-js
     ("action" "signedencrypted")
     ("id" (jsown:val json-object "id"))
     ("text" (read-file temp-encrypted-file)))))

(defun signencrypt-run-gpg (recipient temp-to-encrypt-file temp-encrypted-file)
  (external-program:run
   "/usr/bin/gpg"
   (list
    "--recipient" recipient
    "--output" temp-encrypted-file
    "--encrypt"
    "--sign"
    "--always-trust"
    "--yes"
    "--armor"
    temp-to-encrypt-file)))
