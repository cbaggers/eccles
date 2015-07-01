(in-package :eccles)

;; -    -    -    -    -    -    -    -    -    -    -    -    -

(defclass+ cube (object))

(defun make-cube (&optional (size 1) texture)
  (make-instance 'cube :mesh (make-cube-mesh size)
                 :material (make-instance '1-tex-pnt :tex texture)))
;; -    -    -    -    -    -    -    -    -    -    -    -    -

(defclass+ box (object))

(defun make-box (&optional (dimensions (v! 1 1 1)) texture)
  (make-instance 'cube :mesh (make-box-mesh dimensions)
                 :material (make-instance '1-tex-pnt :tex texture)))

;; -    -    -    -    -    -    -    -    -    -    -    -    -

(defclass+ sphere (object))

(defun make-sphere (&optional (size 1) texture)
  (make-instance 'sphere :mesh (make-sphere-mesh size)
                 :material (make-instance '1-tex-pnt :tex texture)))

;; -    -    -    -    -    -    -    -    -    -    -    -    -

(defclass+ cone (object))

(defun make-cone (&optional (segments 10) (height 1) (radius 0.5) texture)
  (make-instance 'cone :mesh (make-cone-mesh segments height radius)
                 :material (make-instance '1-tex-pnt :tex texture)))

;; -    -    -    -    -    -    -    -    -    -    -    -    -

(defclass+ cylinder (object))

(defun make-cylinder (&optional (segments 10) (height 1) (radius 0.5) texture)
  (make-instance 'cylinder :mesh (make-cylinder-mesh segments height radius)
                 :material (make-instance '1-tex-pnt :tex texture)))

;; -    -    -    -    -    -    -    -    -    -    -    -    -
