(in-package #:eccles)

(defmacro defclass+ (name direct-superclasses &body args)
  `(defclass-triv:defclass-triv ,name ,direct-superclasses ,@args))
