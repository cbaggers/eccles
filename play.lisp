(in-package :eccles)

(defvar cube nil)


(defun setup ()
  (setf cube (make-cube 2 (load-texture "./textures/brick.png"))))


(def-event-listener step-func (e :main-loop-tick)
  (clear)
  (let ((some-num (/ e 1000)))
    (rotate-axis-angle cube (v! (sin some-num) 1 0) some-num))
  (render cube)
  (update-display))
