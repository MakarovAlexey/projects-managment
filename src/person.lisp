(in-package #:projects-managment)

(defclass employee ()
  ((organization :initarg :organization
		 :reader organization-of)
   (person :initarg :person
	   :accessor person-of))
  (:documentation "Трудовой ресурс"))

(defclass person (employee)
  ((full-name :initarg :full-name
	      :accessor full-name-of)
   (employees :initform nil
	      :accessor employees-of))
  (:documentation "Индивидуальный исполнитель"))

(defclass user (person)
  ((login :initarg :login
	  :accessor login-of)
   (password :initarg :password
	     :accessor password-of)
   (email :initarg :email
	  :accessor email-of)))