(in-package #:pgp-ext-app)

(defun decrypt (json-object)
  (let ((email (jsown:val json-object "email"))
	(message (jsown:val json-object "message"))
	(temp-encrypted-file (cat +tmp-folder+ (random-string +tmp-filenames-length+)))
	(temp-decrypted-file (cat +tmp-folder+ (random-string +tmp-filenames-length+))))
    (delete-files (list temp-encrypted-file temp-decrypted-file))
    (with-open-file (file temp-encrypted-file
			  :direction :output
			  :if-does-not-exist :create)
      (format file "~A" message))
    (decrypt-run-gpg email temp-encrypted-file temp-decrypted-file)
    (with-open-file (file temp-decrypted-file)
      (jsown:new-js
	("text" (read-file file))))))

(defun decrypt-run-gpg (email temp-encrypted-file temp-decrypted-file)
  (external-program:run
   "/usr/bin/gpg"
   (list
    "--decrypt"
    "-u" email
    "--output" temp-encrypted-file
    "--yes"
    temp-decrypted-file)))
