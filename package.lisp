;;; package.lisp
;;; Copyright (c) 2012 Robert Smith

;;; Declare the CL-STOPWATCH package

(defpackage #:cl-stopwatch
  (:use #:cl)
  (:export
   ;; stopwatch.lisp
   #:get-accurate-time
   #:stopwatch-start
   #:stopwatch-stop
   #:stopwatch-read
   #:stopwatch-reset
   #:with-stopwatch
   
   ;; progress.lisp
   #:progress-task-start
   #:progress-task-done
   #:progress-task
   
   ;; time.lisp
   #:time*                              ; uses COMPILE
   ))