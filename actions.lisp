(in-package #:pgp-ext-app)

(defparameter +actions+ (make-hash-table :test 'equal))

(defmacro define-action (name args &body body)
  (check-type name symbol)
  `(setf (gethash (symbol-name ',name) +actions+)
	 #'(lambda ,args
	     ,@body)))
