(in-package #:erinome-native)

(defun send-error (buffer)
  (jsown:new-js
    ("text" (concatenate 'string "No action found for: " buffer))))
