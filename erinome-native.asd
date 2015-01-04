(asdf:defsystem #:erinome-native
  :description "The native application of erinome"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on ("jsown" "external-program")
  :components ((:file "package")
	       (:file "actions")
	       (:file "actions/encrypt")
	       (:file "actions/decrypt")
	       (:file "send-error")
	       (:file "erinome-native")))
