;;;; eccles.asd

(asdf:defsystem #:eccles
  :description "CLOSy traditional game object"
  :author "Chris Bagley <techsnuffle@gmail.com>"
  :license "GPLv3"
  :serial t
  :depends-on (#:cepl-default #:defclass-triv)
  :components ((:file "package")
               (:file "base")
               (:file "mesh")
               (:file "material")
               (:file "object")
               (:file "camera")
               (:file "render")
               (:file "init")))
