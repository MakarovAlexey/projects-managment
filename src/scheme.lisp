(in-package #:projects-managment)

(defmmclass project ()
  ((name :initarg :name
	 :accessor name-of)
   (comment :initarg :comment
            :accessor comment-of)
   (task-groups :initform (list)
		:reader task-groups-of)
   (document-lists :initform (list)
		   :reader document-lists-of)))

(defmmclass task-group-child ()
  ((parent :initarg :parent
	   :accessor parent-of)
   (predecessors :initform (list)
		 :reader predecessors-of)
   (name :initarg :name
	 :accessor name-of)))

(defmmclass task-group (task-group-child)
  ((children :initform (list)
	     :reader children-of)))

(defmmclass task (task-group-child)
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
	     :reader comments-of)))

(defmmclass comment ()
  ((author :initarg :author
	   :accessor author-of)
   (text :initarg :text
	 :accessor text-of)))

(defmmclass document-list ()
  ((documents :initform (list)
	      :reader documents-of)
   (properties :initform (list)
	       :reader properties-of)))

(defmmclass document ()
  ((document-list :initarg :document-list
		  :accessor document-list-of)
   (properties :initform (list)
	       :reader properties-of)
   (stream :initarg :stream
	   :accessor stream-of)))