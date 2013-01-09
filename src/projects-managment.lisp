(in-package #:projects-managment)

(defclass task ()
  ((name :initarg :name
	 :accessor name-of)
   (task-group :initarg :task-group
	       :accessor task-group-of))
  (:metaclass project-managment-class))

(defclass task-group ()
  ((name :initarg :name
	 :accessor name-of)
   (task-groups :initform (make-array 0 :element-type task-group
				      :fill-pointer t
				      :adjustable t)
		:reader task-groups-of)
   (tasks :initform (make-array 0 :element-type task
				:fill-pointer t
				:adjustable t)
	  :reader tasks-of))
  (:metaclass project-managment-class))

(defclass common-task-group (task-group)
  ((parent-task-group :initarg :parent
		      :accessor parent-task-group-of))
  (:metaclass project-managment-class))

(defclass root-task-group (task-group) ()
  (:metaclass project-managment-class))

(defclass project (repository)
  ((name :initarg :name
	 :accessor name-of)
   (root-task-groups :initform (make-array 0 :element-type root-task-group
					   :fill-pointer t
					   :adjustable t)
		     :reader root-task-groups-of))
  (:metaclass project-managment-class))

;;(define-dependency root-task-group
;;    (project (root-task-groups :reader root-task-groups-of)
;;	     (project :reader project-of)))

;;(define-dependency task-group
;;    (task (tasks :reader tasks-of)
;;	  (task-group :reader task-group-of)))

;; ассоциации (associations) как механизм определения отношений объектов классов
;; реализация поведения слота определяется в отношении, а не значением слота

;;(manardb:use-mmap-dir "/home/amakarov/src/lisp/projects-managment/data/"
;;		      :if-does-not-exist :create)
;;(open-all-mmaps)

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