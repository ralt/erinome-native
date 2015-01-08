(in-package #:erinome-native)

(defvar +tmp-folder+ "/tmp/")
(defvar +tmp-filenames-length+ 29)

(defun main ()
  "Application's entry point."
  (loop (main-loop)))

(defun main-loop ()
  (let* ((buffer (chrome-native-messaging:read-from-ext *standard-input*))
	 (json-object (jsown:parse buffer))
	 (action (string-upcase (jsown:val json-object "action"))))
    (chrome-native-messaging:send-to-ext
     (jsown:to-json
      (handler-case
	  (funcall (gethash action +actions+) json-object)
	(error () (jsown:new-js
		    ("action" "error")
		    ("type" action)))))
     *standard-output*)))

(defun delete-files (files)
  (mapcar #'(lambda (file)
	      (when (probe-file file)
		(delete-file file)))
	  files))

(defun random-string (length)
  (with-output-to-string (stream)
    (let ((*print-base* 36))
      (loop repeat length do (princ (random 36) stream)))))

(defun read-file (file)
  (loop for line = (read-line file nil)
     while line
     collect line))
