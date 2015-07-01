(in-package :eccles)

(defgeneric render-material (camera material vbuffer transform))

;;--------------------------------------------------------------

(defmethod render-material ((camera camera) (material 1-tex-pnt)
                            (mesh pnt-mesh) transform)

  (map-g (pipeline material) (vstream mesh) :model->clip transform
         :tex (tex material)))

;;--------------------------------------------------------------
