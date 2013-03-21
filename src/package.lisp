;;;; package.lisp

(defpackage #:projects-managment
  (:use #:cl)
  (:import-from :hu.dwim.perec
		:defpclass*
		:defpassociation*
		:with-database
		:with-transaction))

(restas:define-module #:projects-managment.web
  (:use #:cl #:projects-managment)
  (:import-from :hu.dwim.perec
		:defpclass*
		:defpassociation*
		:with-database
		:with-transaction))