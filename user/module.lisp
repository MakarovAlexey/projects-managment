(setf hunchentoot:*show-lisp-errors-p* t)

(restas:define-module #:projects-managment.user
  (:use #:cl #:projects-managment)
  (:export :index))

;;  (:decorators #'projects-managment.authentication:@http-auth-require))

(in-package #:projects-managment.user)

;;(restas:mount-submodule auth (#:projects-managment.authentication))
;;(restas:mount-submodule auth (#:projects-managment.authentication))