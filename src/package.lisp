;;;; package.lisp

(defpackage #:projects-managment
  (:use #:cl)
  (:import-from :hu.dwim.perec
		:defpclass*
		:defpassociation*
		:with-database
		:with-transaction))