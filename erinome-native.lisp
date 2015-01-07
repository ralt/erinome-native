(in-package #:erinome-native)

(defvar +tmp-folder+ "/tmp/")
(defvar +tmp-filenames-length+ 29)

(defun main ()
  "Application's entry point."
  (loop (main-loop)))

(defun main-loop ()
  (let* ((length (read-length *standard-input*))
	 (buffer (read-stdin-as-string length))
	 (json-object (jsown:parse buffer))
	 (action (string-upcase (jsown:val json-object "action"))))
    (send-to-ext
     (jsown:to-json
      (handler-case
	  (funcall (gethash action +actions+) json-object)
	(error () (jsown:new-js
		    ("action" "error")
		    ("type" action))))))))

(defun read-stdin-as-string (length)
  (let ((string (make-string length)))
    (read-sequence string *standard-input*)
    string))

(defun read-length (stream)
  (handler-case
      (+
       (read-byte stream)
       (* (read-byte stream) (expt 2 8))
       (* (read-byte stream) (expt 2 16))
       (* (read-byte stream) (expt 2 24)))
    ; When no byte is available, it means the communication is cut off
    (end-of-file () (sb-ext:exit))))

(defun integer-to-bytes (integer)
  (list
   (logand integer #xFF)
   (logand (ash integer -8) #xFF)
   (logand (ash integer -16) #xFF)
   (logand (ash integer -24) #xFF)))

(defun send-to-ext (str)
  (let ((len (length str)))
    (dolist (byte (integer-to-bytes len))
      (write-byte byte *standard-output*))
    (dolist (byte (coerce str 'list))
      (write-byte (char-code byte) *standard-output*)))
  (force-output))

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
