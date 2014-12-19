(in-package #:pgp-ext-app)

(defun main ()
  "Application's entry point."
  (loop (main-loop)))

(defun main-loop ()
  (let* ((length (read-length *standard-input*))
	 (buffer (read-stdin-as-string length))
	 (json-object (jsown:parse buffer))
	 (action (jsown:val json-object "action")))
    (send-to-ext
     (jsown:to-json
      (alexandria:switch (action :test 'equal)
	("encrypt" (encrypt json-object))
	(otherwise (send-error buffer)))))))

(defun read-stdin-as-string (length)
  (let ((string (make-string length)))
    (read-sequence string *standard-input*)
    string))

(defun read-length (stream)
  (+
   (read-byte stream)
   (* (read-byte stream (expt 2 8)))
   (* (read-byte stream (expt 2 16)))
   (* (read-byte stream (expt 2 24)))))

(defun integer-to-chars (integer)
  (mapcar
   #'code-char
   (list
    (logand integer #xFF)
    (logand (ash integer -8) #xFF)
    (logand (ash integer -16) #xFF)
    (logand (ash integer -24) #xFF))))

(defun send-to-ext (str)
  (let ((len (length str)))
    (format t
	    "~{~C~}~A"
	    (integer-to-chars len)
	    str)
    (force-output)))
