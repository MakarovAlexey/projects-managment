(restas:define-module #:projects-managment.root
  (:use #:cl #:projects-managment))

(in-package #:projects-managment.root)

(defclass user-authentication ()
  ((name :initarg :name :accessor name-of)))

(defclass user-auth-route (routes:proxy-route) ())

(defmethod routes:route-check-conditions ((route user-auth-route) bindings)
  (when (not (and (call-next-method)
		  (typep (hunchentoot:session-value :authentication) 'user-authentication)))
    (restas:redirect 'login)))

(defun @user-auth-require (route)
  (make-instance 'user-auth-route :target route))

(restas:mount-module user (#:projects-managment.user)
  (:inherit-parent-context t)
  (:url "/user/")
  (:decorators '@user-auth-require))

(defclass admin-authentication () ())

(defclass admin-auth-route (routes:proxy-route) ())

(defmethod routes:route-check-conditions ((route admin-auth-route) bindings)
  (when (not (and (call-next-method)
		  (typep (hunchentoot:session-value :authentication) 'admin-authentication)))
    (restas:redirect 'login)))

(defun @admin-auth-require (route)
  (make-instance 'admin-auth-route :target route))

(restas:mount-module admin (#:projects-managment.admin)
  (:inherit-parent-context t)
  (:url "/admin/")
  (:decorators '@admin-auth-require))

(restas:define-route home ("/")
  (multiple-value-bind (value presentp) (hunchentoot:session-value :authentication)
    (if presentp
	(redirect-authenticated value)
	(restas:redirect 'login))))

(defgeneric redirect-authenticated (authentication))

(defmethod redirect-authenticated ((authentication user-authentication))
  (restas:redirect 'projects-managment.user:index))

(defmethod redirect-authenticated ((authentication admin-authentication))
  (restas:redirect 'admin.home))

(restas:define-route login ("/login")
  (projects-managment.site.login:page))

(restas:define-route root-login ("/root-login" :method :post)
  (if (string= (hunchentoot:post-parameter "password") "zxcvb")
      (redirect-authenticated
       (setf (hunchentoot:session-value :authentication)
	     (make-instance 'admin-authentication)))
      (restas:redirect 'login)))

(restas:define-route user-login ("/user-login" :method :post)
  (setf (hunchentoot:session-value :authentication)
	     (make-instance 'user-authentication :name "makarov"))
  (restas:redirect 'user.index))