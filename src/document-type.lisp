(in-package #:projects-managment)

(defclass document-directory ()
  ((name :initarg :name
	 :accessor name-of)
   (subdirectories :initform nil
		   :accessor subdirectories-of)
   (document-types :initform nil
	      :accessor document-types-of)))

(defclass root-directory (document-directory) ())

(defclass common-directory (document-directory)
  ((parent-directory :initarg :parent-directory
		     :accessor parent-directory-of)))

(defclass document-type ()
  ((name :initarg :name
	 :accessor name-of)
   (parent-directory :initarg :parent-directory
		     :accessor parent-directory-of))
  (:documentation "Тип документа"))