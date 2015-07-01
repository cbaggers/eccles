(in-package :eccles)

(defclass+ mesh ()
  vbuffers
  vstream)

;;-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

(defclass+ pnt-mesh (mesh))


(defun make-cube-mesh (&optional (size 1))
  (let ((size (coerce size 'single-float)))
    (%prim-data-to-pnt-mesh (primitives:box-data :width size
                                                 :height size
                                                 :depth size))))

(defun make-box-mesh (&optional (dimensions (v! 1 1 1)))
  (%prim-data-to-pnt-mesh (primitives:box-data :width (v:x dimensions)
                                               :height (v:y dimensions)
                                               :depth (v:z dimensions))))


(defun make-sphere-mesh (&optional (radius 1))
  (let ((size (coerce size 'single-float)))
    (%prim-data-to-pnt-mesh (primitives:sphere-data :radius radius))))


(defun make-cone-mesh (&optional (segments 10) (height 1) (radius 0.5))
  (let ((height (coerce height 'single-float))
        (radius (coerce radius 'single-float)))
    (%prim-data-to-pnt-mesh (primitives:cone-data
                             :segments segments :height height :radius radius))))

(defun make-cylinder-mesh (&optional (segments 10) (height 1) (radius 0.5))
  (let ((height (coerce height 'single-float))
        (radius (coerce radius 'single-float)))
    (%prim-data-to-pnt-mesh (primitives:cylinder-data
                             :segments segments :height height :radius radius))))

;;-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

(defun %prim-data-to-pnt-mesh (data)
  (destructuring-bind (v i) data
      (let* ((va (make-gpu-array v :element-type 'g-pnt))
             (ia (make-gpu-array i :element-type :ushort))
             (bs (make-buffer-stream va :index-array ia)))
        (make-instance 'pnt-mesh :vstream bs :vbuffers (list va ia)))))
