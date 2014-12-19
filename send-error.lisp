(in-package #:pgp-ext-app)

(defun send-error (buffer)
  (jsown:new-js
    ("text" (concatenate 'string "No action found for: " buffer))))
