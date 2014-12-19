(asdf:defsystem #:pgp-ext-app
  :description "The native application of pgp-ext"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on ("bordeaux-threads" "jsown")
  :components ((:file "package")
	       (:file "encrypter")
               (:file "pgp-ext-app")))
