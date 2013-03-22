;;;; projects-managment.lisp

(in-package #:projects-managment)

;;; "projects-managment" goes here. Hacks and glory await!

(defclass database-connection (hu.dwim.perec:database-mixin
			       hu.dwim.rdbms.postgresql:postgresql) ())

(defparameter hu.dwim.perec:*database*
  (make-instance 'database-connection
		 :connection-specification
		 '(:database "projects"
		   :user-name "amakarov"
		   :password "zxcvb")))

(defmethod hu.dwim.rdbms::calculate-rdbms-name ((db database-connection) thing name)
  (hu.dwim.rdbms::calculate-rdbms-name-with-utf-8-length-limit (append name "s")
							       hu.dwim.rdbms.postgresql::+maximum-rdbms-name-length+
							       :prefix ""))
