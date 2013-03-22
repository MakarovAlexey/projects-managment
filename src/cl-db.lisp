(in-package #:projects-managment)

(defclass project ()
  ((name :initarg :name
	 :accessor name-of
	 :column-type (varchar 50))
   (comment :initarg :comment
            :accessor comment-of
	    :column-type text)
   (xml :initarg :xml
	:accessor xml-of
	:column-type xml)
  (:metaclass persistent-class))

   (task-groups :initform (list)
		:reader task-groups-of)
   (document-lists :initform (list)
		   :reader document-lists-of))

(defclass task-group-child ()
  ((name :initarg :name
	 :accessor name-of
	 :column-type (varchar 50))
   (parent :initarg :parent
	   :accessor parent-of)
   (predecessors :initform (list)
	      :reader predecessors-of))
  (:metaclass persistent-class))

(defclass task-group (task-group-child)
  ((children :initform (list)
	     :reader children-of))
  (:metaclass persistent-class))

(define-association
    (task-group-child parent)
    (task-group children))
















(defclass task (task-group-child)
  ((days :initarg :days
	 :accessor days-of)
   (begin-date :initarg :begin-date
	       :accessor begin-date-of)
   (end-date :initarg :end-date
	     :accessor end-date-of)
   (complite-date :initarg :complite-date
		  :accessor complite-date-of)
   (executor :initarg :executor
	     :accessor executor-of)
   (comments :initform (list)
	     :reader comments-of))
  (:metaclass persistent-class))

(defclass comment ()
  ((author :initarg :author
	   :accessor author-of)
   (text :initarg :text
	 :accessor text-of)))

(defclass document-list ()
  ((documents :initform (list)
	      :reader documents-of)
   (properties :initform (list)
	       :reader properties-of))
  (:metaclass persistent-class))

(defclass document ()
  ((document-list :initarg :document-list
		  :accessor document-list-of)
   (properties :initform (list)
	       :reader properties-of)
   (stream :initarg :stream
	   :accessor stream-of))
  (:metaclass persistent-class))