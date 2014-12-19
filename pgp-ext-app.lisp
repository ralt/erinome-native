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
      (when (string= action "encrypt")
	(encrypt json-object))))))

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
  (mapcar #'code-char
	  (list
	   (ash integer 0)
	   (logand (ash integer (* 1 8)) #xFF)
	   (logand (ash integer (* 2 8)) #xFF)
	   (logand (ash integer (* 3 8)) #xFF))))

(defun send-to-ext (str)
  (let ((len (length str)))
    (format *standard-output*
	    "~{~c~}~A"
	    (integer-to-chars len)
	    str)))
