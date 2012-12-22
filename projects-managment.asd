;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
(defpackage #:projects-managment-asd
  (:use :cl :asdf))

(in-package :projects-managment-asd)

(defsystem projects-managment
    :name "projects-managment"
    :version "0.0.1"
    :maintainer ""
    :author ""
    :licence ""
    :description "projects-managment"
    :depends-on (:hunchentoot
		 :cl-who
		 :restas
		 :closure-template
		 :manardb
		 :postmodern
		 :trivial-gray-streams
		 :lift)
    :defsystem-depends-on (:closure-template)
    :serial t
    :components ((:module "templates"
			  :components ((:closure-template-file "index")))
		 (:module "src"
                          :depends-on ("templates")
			  :components ((:file "packages")
				       (:file "large-object")
				       (:file "large-object-tests")
				       (:file "scheme")
				       (:file "projects-managment")
				       (:file "web")))))