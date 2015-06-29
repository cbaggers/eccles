(in-package :eccles)

(defclass+ material ()
  pipeline)

(defgeneric render-material (camera material vbuffer transform))

;;--------------------------------------------------------------

(defclass+ pnt-material (material))

(defclass+ 1-tex-material (material)
  tex)

(defclass+ 1-tex-pnt (pnt-material 1-tex-material))

(defmethod render-material ((camera camera) (material 1-tex-pnt)
                            (vstream cgl::vertex-stream) transform)
  (map-g (pipeline material) vstream :tex (tex material)))

;;    -    -    -    -    -    -    -    -    -    -    -    -

(defun-g simple-pnt-vert ((vert g-pnt) &uniform (model->clip :mat4))
  (values (* model->clip (v! (pos vert) 1.0))
          (tex vert)))

(defun-g 1-tex-frag ((tc :vec2) &uniform (tex :sampler-2d))
  (texture tex tc))

(defpipeline 1-tex-pipeline () (g-> #'simple-pnt-vert #'1-tex-frag))

;;--------------------------------------------------------------
