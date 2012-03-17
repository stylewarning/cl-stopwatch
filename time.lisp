;;; time.lisp
;;; Copyright (c) 2012 Robert Smith

;;; An alternative timing form which compiles before executing.

(in-package #:cl-stopwatch)

(defmacro time* (form)
  "Freshly compile FORM and time its execution."
  (let ((f (gensym "F-")))
    `(let ((,f (compile nil (lambda () (time ,form)))))
       (funcall ,f))))