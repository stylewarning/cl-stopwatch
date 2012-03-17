;;; progress.lisp
;;; Copyright (c) 2012 Robert Smith

;;; Functions/macros to indicate progress.

(in-package #:cl-stopwatch)

(defparameter *progress-indent* 0)

(defun progress-task-start (kw string &optional (stream *standard-output*))
  "Start a task designated by the keyword KW, with a comment STRING,
and print an indication that the task has started and start a
stopwatch. Print everything to STREAM."
  (stopwatch-start kw)
  (incf *progress-indent*)
  (format stream ";;;~A~A: ~A...~%"
	  (make-string (* 2 *progress-indent*) :initial-element #\space)
	  kw
	  string)
  (values))

(defun progress-task-done (kw &optional (stream *standard-output*))
  "End the task designated by the keyword KW and report its completion
time to STREAM."
  (format stream ";;;~A~A: Done. [~F ms]~%"
	  (make-string (* 2 *progress-indent*) :initial-element #\space)
	  kw
          (stopwatch-stop kw))
  (decf *progress-indent*)
  (values))

(defmacro progress-task (kw string &body body)
  "Execute BODY, reporting the task, labeled by the keyword KW and
commented with STRING. Report its end time and return the value
returned by BODY."
  `(progn
     (progress-task-start ,kw ,string)
     (prog1 (progn ,@body)
       (progress-task-done ,kw))))
