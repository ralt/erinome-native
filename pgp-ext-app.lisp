(in-package #:pgp-ext-app)

(defun main ()
  "Application's entry point."
  (loop
     (let* ((length (read-length *standard-input*))
	    (buffer (read-stdin-as-string length)))
       (send-to-ext
	(jsown:to-json
	 (list :obj (cons "text" buffer)))))))

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

(defun integer-to-chars (integer length)
  (loop for i from 0 upto (- length 1)
     collect (code-char (logand (ash integer (* i 8)) #xFF))))

(defun send-to-ext (str)
  (let ((len (length str)))
    (format *standard-output*
	    "~{~c~}~A"
	    (integer-to-chars len 4)
	    str))
  (force-output *standard-output*))
