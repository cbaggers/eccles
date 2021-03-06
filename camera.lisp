(in-package :eccles)

(defvar *default-camera* nil)

(defun init-camera-backend ()
  (setf *default-camera* (make-instance 'camera)))

;;;--------------------------------------------------------------

(defclass+ camera (object)
  (cam->clip)
  (near :initform 1.0 :reader near)
  (far :initform 1000.0 :reader far)
  (fov :initform 120.0 :reader fov)
  (frame-size :initform (cgl:viewport-resolution (cgl:current-viewport))
              :reader frame-size)
  (world-up :initform (v! 0.0 1.0 0.0)))

(defmethod initialize-instance :after ((cam camera) &key)
  (update-cam->clip cam))

(defmethod update-cam->clip ((camera camera))
  (setf (cam->clip camera)
        (projection:perspective (first (frame-size camera))
                                (second (frame-size camera))
                                (near camera)
                                (far camera)
                                (fov camera))))

(defmethod (setf near) (distance (camera camera))
  (setf (slot-value camera 'near) distance)
  (update-cam->clip camera))

(defmethod (setf far) (distance (camera camera))
  (setf (slot-value camera 'far) distance)
  (update-cam->clip camera))

(defmethod (setf fov) (angle (camera camera))
  (setf (slot-value camera 'fov) angle)
  (update-cam->clip camera))

(defmethod (setf frame-size) (frame (camera camera))
  (let ((frame
         (etypecase frame
            ((simple-array single-float (2)) (list (aref frame 0)
                                                   (aref frame 1)))

            (cgl:viewport (cgl:viewport-resolution frame))
            (list frame))))
    (setf (slot-value camera 'frame-size) frame))
  (update-cam->clip camera))


(defmethod look-at (camera point-vec3)
  (with-slots (node) camera
    (setf (pqn-quat node)
          (q:make-quat-from-look-at (pqn-pos node) point-vec3))))

(defmethod world->cam ((camera camera))
  (with-slots (node) camera
    (m4:m* (m4:translation (pqn-pos node))
           (q:to-matrix4 (q:inverse (pqn-quat node))))))

(defmethod world->clip (camera)
  (m4:m* (cam->clip camera)
         (world->cam camera)))

;;;--------------------------------------------------------------
