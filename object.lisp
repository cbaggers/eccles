(in-package :eccles)

(defclass+ object ()
  (node :initform (make-pos-quat-node))
  mesh
  material)

(defmethod render ((obj object) &optional (camera *default-camera*))
  (with-slots (node mesh material) obj
    (render-material camera material mesh
                     (m4:m* (world->clip camera)
                            (node-transform node)))))

(defclass+ cube (object))

(defun make-cube (&optional (size 1) texture)
  (make-instance 'cube :mesh (make-cube-mesh size)
                 :material (make-instance '1-tex-pnt :tex texture)))

(defclass+ sphere (object))

(defun make-sphere (&optional (size 1) texture)
  (make-instance 'sphere :mesh (make-sphere-mesh size)
                 :material (make-instance '1-tex-pnt :tex texture)))


(defmethod pos ((object object))
  (with-slots (node) object
    (pqn-pos node)))

(defmethod (setf pos) (value (object object))
  (with-slots (node) object
    (setf (pqn-pos node) value)))

(defmethod rot ((object object))
  (with-slots (node) object
    (pqn-quat node)))

(defmethod rotate-axis-angle ((object object) axis angle)
  (setf (rot object) (q:make-quat-from-axis-angle axis angle)))

(defmethod (setf rot) (value (object object))
  (with-slots (node) object
    (setf (pqn-quat node) value)))

(defmethod texture ((object object))
  (with-slots (material) object
    (texture material)))

(defmethod (setf texture) (value  (object object))
  (with-slots (material) object
    (setf (texture material) value)))
