(in-package #:pgp-ext-app)

(defun main ()
  "Application's entry point."
  (loop
     (let* ((length (read-length *standard-input*))
	    (buffer (chars-to-string (read-stdin length))))
       (send-to-ext
	(jsown:to-json
	 (list :obj (cons "text" buffer)))))))

(defun read-stdin (length)
  (loop for i from 0 upto (- length 1)
     collect (read-char *standard-input*)))

(defun read-length (stream)
  (+
   (read-byte stream)
   (* (read-byte stream (expt 2 8)))
   (* (read-byte stream (expt 2 16)))
   (* (read-byte stream (expt 2 24)))))

(defun chars-to-string (chars)
  (format nil "~{~c~}" chars))

(defun string-to-chars (string)
  (loop for c across string collect c))

(defun integer-to-chars (integer length)
  (loop for i from 0 upto (- length 1)
     collect (code-char (logand (ash integer (* i 8)) #xFF))))

(defun send-to-ext (str)
  (let ((len (length str)))
    (format *standard-output*
	    "~{~c~}~{~c~}"
	    (integer-to-chars len 4)
	    (string-to-chars str)))
  (force-output *standard-output*))
