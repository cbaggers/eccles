(in-package :eccles)

(defclass+ object ()
  (node :initform (make-pos-quat-node))
  mesh
  material)

(defmethod render-object ((obj object) &optional (camera *default-camera*))
  (with-slots (node mesh material) obj
    (render-material camera material (vstream mesh)
                     (m4:m* (world->clip camera)
                            (node-transform node)))))

(defclass+ cube (object))

(defun make-cube (&optional (size 1) texture)
  (make-instance 'cube :mesh (make-cube-mesh size)
                 :material (make-instance '1-tex-material :tex texture)))
