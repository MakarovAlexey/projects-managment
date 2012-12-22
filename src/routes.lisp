(restas:define-module #:projects-managment.routes
    (:use :cl :cl-user :cl-who :projects-managment))

(in-package :projects-managment.routes)

;;(restas:start '#:projects-managment-web :port 8088)

(defun get-object (id-string)
  (manardb:mptr-to-lisp-object (parse-integer id-string)))

(setf hunchentoot:*catch-errors-p* nil)

(restas:define-route main ("" :method :get)
  (projects-managment-templates:index))