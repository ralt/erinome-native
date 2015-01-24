(in-package #:erinome-native)

(define-action decrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message"))
	(temp-encrypted-file (random-path))
	(temp-decrypted-file (random-path)))
    (delete-files (list temp-encrypted-file temp-decrypted-file))
    (write-file temp-encrypted-file (clean-ws message))
    (decrypt-run-gpg email temp-encrypted-file temp-decrypted-file)
    (jsown:new-js
     ("action" "decrypted")
     ("sender" (jsown:val json-object "name"))
     ("text" (read-file temp-decrypted-file)))))

(defun decrypt-run-gpg (email temp-encrypted-file temp-decrypted-file)
  (external-program:run
   "/usr/bin/gpg"
   (list
    "--decrypt"
    "-u" email
    "--output" temp-decrypted-file
    "--yes"
    "--always-trust"
    temp-encrypted-file)))

(defun clean-ws (text)
  "Clean up whitespaces"
  (format
   nil
   "~{~A~%~}"
   (loop for line in (split-sequence:split-sequence #\Newline text)
      collect (string-left-trim " " line))))
