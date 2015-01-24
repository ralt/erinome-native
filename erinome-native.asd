(asdf:defsystem #:erinome-native
  :description "The native application of erinome"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on ("jsown"
	       "external-program"
	       "chrome-native-messaging"
	       "split-sequence")
  :components ((:file "package")
	       (:file "actions")
	       (:file "actions/encrypt")
	       (:file "actions/decrypt")
	       (:file "actions/sign")
	       (:file "actions/signencrypt")
	       (:file "actions/verify")
	       (:file "erinome-native")))
