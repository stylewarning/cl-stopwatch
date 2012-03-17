(defpackage #:cl-stopwatch-asd
  (:use #:cl #:asdf))

(in-package #:cl-stopwatch-asd)

(defsystem cl-stopwatch
  :name "cl-stopwatch"
  :version "0.1"
  :author "Robert Smith"
  :description "Timing and clocking in Common Lisp."
  :license "BSD 3-clause. See LICENSE."
  
  :serial t
  :components ((:file "package")
               (:file "stopwatch")
               (:file "progress")
               (:file "time")           ; This uses COMPILE.
               ))
