(in-package #:erinome-native)

(define-action verify (json-object)
  (let ((text (jsown:val json-object "text"))
	(temp-to-verify-file (random-path)))
    (delete-files (list temp-to-verify-file))
    (write-file temp-to-verify-file text)
    (jsown:new-js
     ("action" "verified")
     ("id" (jsown:val json-object "id"))
     ("result" (verify-run-gpg temp-to-verify-file)))))

(defun verify-run-gpg (temp-to-verify-file)
  (multiple-value-bind (_ status)
      (external-program:run
       "/usr/bin/gpg"
       (list
	"--verify"
	temp-to-verify-file))
    (declare (ignore _))
    status))
