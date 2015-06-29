;;;; eccles.asd

(asdf:defsystem #:eccles
  :description "Describe eccles here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:cepl #:defclass-triv)
  :components ((:file "package")
               (:file "base")
               (:file "object")))
