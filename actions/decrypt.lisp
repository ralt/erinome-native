(in-package #:erinome-native)

(define-action decrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message"))
	(temp-encrypted-file (concatenate 'string +tmp-folder+ (random-string +tmp-filenames-length+)))
	(temp-decrypted-file (concatenate 'string +tmp-folder+ (random-string +tmp-filenames-length+))))
    (delete-files (list temp-encrypted-file temp-decrypted-file))
    (with-open-file (file temp-encrypted-file
			  :direction :output
			  :if-does-not-exist :create)
      (format file "~A" message))
    (decrypt-run-gpg email temp-encrypted-file temp-decrypted-file)
    (with-open-file (file temp-decrypted-file)
      (jsown:new-js
        ("action" "decrypted")
	("sender" (jsown:val json-object "name"))
	("text" (read-file file))))))

(defun decrypt-run-gpg (email temp-encrypted-file temp-decrypted-file)
  (external-program:run
   "/usr/bin/gpg"
   (list
    "--decrypt"
    "-u" email
    "--output" temp-decrypted-file
    "--yes"
    temp-encrypted-file)))
