(restas:define-module #:projects-managment.admin
  (:use :cl)
  (:export :home))

(in-package #:projects-managment.admin)

(restas:define-route home ("admin")
  (projects-managment.admin.index:page))