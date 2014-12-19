(asdf:defsystem #:pgp-ext-app
  :description "The native application of pgp-ext"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on ("jsown" "alexandria" "external-program")
  :components ((:file "package")
	       (:file "send-error")
	       (:file "encrypter")
	       (:file "decrypter")
               (:file "pgp-ext-app")))
