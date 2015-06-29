(in-package :eccles)

(defclass+ mesh ()
  vbuffers
  vstream)

(defun make-cube-mesh (&optional (size 1))
  (let ((size (coerce size 'single-float)))
    (destructuring-bind (v i) (primitives:box-data :width size
                                                   :height size
                                                   :depth size)
      (let* ((va (make-gpu-array v :element-type 'g-pnt))
             (ia (make-gpu-array i :element-type :ushort))
             (bs (make-buffer-stream va :index-array ia)))
        (make-instance 'mesh :vstream bs :vbuffers (list va ia))))))
