(in-package :eccles)

;;--------------------------------------------------------------

(defun load-texture (path)
  (devil-helper:load-image-to-texture path))

;;--------------------------------------------------------------

(defclass+ material ()
  (pipeline :initform (error ":pipeline is mandatory when creating a material")))

(defclass+ pnt-material (material))

(defclass+ 1-tex-material (material)
  tex)

(defmethod texture ((mat 1-tex-material))
  (slot-value mat 'tex))

(defmethod (setf texture) (value (mat 1-tex-material))
  (setf (slot-value mat 'tex) value))

;;--------------------------------------------------------------

(defclass+ 1-tex-pnt (pnt-material 1-tex-material)
  (pipeline :initform #'1-tex-pipeline))

;;    -    -    -    -    -    -    -    -    -    -    -    -

(defun-g simple-pnt-vert ((vert g-pnt) &uniform (model->clip :mat4))
  (values (* model->clip (v! (pos vert) 1.0))
          (tex vert)))

(defun-g 1-tex-frag ((tc :vec2) &uniform (tex :sampler-2d))
  (texture tex tc))

(cepl:defpipeline 1-tex-pipeline () (g-> #'simple-pnt-vert #'1-tex-frag))

;;--------------------------------------------------------------
