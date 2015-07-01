(in-package :eccles)

(defun init ()
  (unless cgl:*gl-context*
    (cepl:init 640 480 :sdl "Eccles" t))
  (init-camera-backend))

(let ((running nil))

  (defun is-running ()
    running)

  (defun run-main-loop ()
    (setf running t)
    (print "--- Eccles Main Loop Running ---")
    (force-output)
    (loop :while running :do
       (continuable
         (update-swank)
         (evt:pump-events)
         (main-loop-tick (get-internal-real-time)))))

  (defun stop-main-loop ()
    (setf running nil)))

(def-event-listener %system-listener (e :sys)
  (when (typep e 'evt:will-quit) (stop-main-loop)))

(evt::def-special-event-listener main-loop-tick (:parent nil :filter nil))
