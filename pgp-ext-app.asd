(asdf:defsystem #:pgp-ext-app
  :description "The native application of pgp-ext"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on ("bordeaux-threads" "jsown" "alexandria")
  :components ((:file "package")
	       (:file "send-error")
	       (:file "encrypter")
               (:file "pgp-ext-app")))
