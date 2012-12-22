(in-package #:projects-managment)

(manardb:use-mmap-dir "/home/makarov/projects/projects-managment/data/"
		      :if-does-not-exist :create)
(open-all-mmaps)

					;****
 
;;(defmmclass document-collection ()
;;  ((documents :initform nil
;;	      :accessor documents-of)))

;;(defmmclass group (document-collection)
;;  ((name :initarg :name
;;	 :accessor name-of)
;;   (comment :initarg :comment
;;	    :accessor comment-of)
;;   (subgroups :initform nil
;;	      :accessor subgroups-of)
;;   (documents-for-choice :initform nil
;;			:accessor documents-for-choice-of)))

;;(defmmclass root-group (group) ())

;;(defmmclass group-element ()
;;  ((parent-group :initarg :parent-group
;;		 :initform nil
;;		 :accessor parent-group-of)))

;;(defmmclass document-group (group-element) ())

;;(defmmclass documents-for-choice (group-element document-collection) ())

;;(defmmclass document (group-element)
;;  ((name :initarg :name :accessor name-of)
;;   (comment :initarg :comment :accessor comment-of)
;;   (dependencies :initform nil
;;		 :accessor dependencies-of)))