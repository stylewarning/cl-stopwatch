;;; stopwatch.lisp
;;; Copyright (c) 2012 Robert Smith

;;; Simple stopwatch functionality.

(in-package #:cl-stopwatch)

(defparameter *stopwatch-timing* (make-hash-table))

(defmacro get-accurate-time ()
  "Get the time in milliseconds, accurately."
  '(values (floor (* 1000 (get-internal-real-time))
                  internal-time-units-per-second)))

(defun stopwatch-start (kw)
  "Start a stopwatch designated by KW."
  (setf (gethash kw *stopwatch-timing*) (get-accurate-time)))

(defun stopwatch-read (kw)
  "Read a stopwatch designated by KW."
  (- (get-accurate-time) (gethash kw *stopwatch-timing*)))

(defun stopwatch-stop (kw)
  "Stop the stopwatch designated by KW and return the reading in milliseconds."
  (prog1 (stopwatch-read kw)
    (remhash kw *stopwatch-timing*)))

(defun stopwatch-reset (kw)
  "Resets the stopwatch designated by KW. Equivalent to starting it."
  (setf (gethash kw *stopwatch-timing*) (get-accurate-time)))

(defmacro with-stopwatch (&body body)
  "Execute BODY, returning its value as well as the value of the watch."
  (let ((kw     (gensym))
        (result (gensym)))
    `(progn
       (stopwatch-start ',kw)
       (let ((,result (progn ,@body)))
         (values ,result
                 (stopwatch-stop ',kw)))))) ;FIXME: delete the stopwatch
