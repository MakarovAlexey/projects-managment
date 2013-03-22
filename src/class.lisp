(in-package #:projects-managment)

(defclass project-managment-class (standard-class) ())

(defmethod validate-superclass ((class project-managment-class)
				(superclass standard-class))
  t)

(defclass project-managment-object ()
  ((commited-changes :initform (make-hash-table)
		     :reader slot-changes-of)
   (head-changes :initform (make-hash-table)
		 :reader head-changes-of)))

(defclass repository ()
  ((branches :initform (make-array 0 :element-type branch
				   :fill-pointer t
				   :adjustable t)
	     :reader branches-of)
   (current-branch :accessor current-branch-of)))

(defclass branch ()
  ((repository :initarg :repository
	       :reader repository-of)
   (commits :initform (make-array 0 :element-type commit
				  :fill-pointer t
				  :adjustable t)
	    :reader commits-of)))

(defclass commit ()
  ((branch :initarg :branch
	   :reader branch-of)
   (changes :initform (make-array 0 )))

(defclass initial-commit (commit)
  ())

(defclass common-commit (commit)
  ((previous-commit :initarg :previous-commit
		    :reader previous-commit-of)))

(defclass property-slot-definition
    (standard-direct-slot-definition)
  ())

(defclass property-direct-slot-definition
    (standard-direct-slot-definition property-slot-definition)
  ((version-control-p :initarg :version-control-p
		      :initform t
		      :reader version-control-p)))

(defmethod direct-slot-definition-class ((class project-managment-class)
					 &key (version-control-p t) &allow-other-keys)
  (if (not (null version-control-p))
      (find-class 'property-direct-slot-definition)
      (find-class 'standard-direct-slot-definition)))

(defclass property-effective-slot-definition
    (standard-effective-slot-definition property-slot-definition)
  ())

(defmethod slot-value-using-class ((class project-managment-class)
				   instance (slot property-effective-slot-definition))
  ())

(defclass collection-effective-slot-definition
    (standard-effective-slot-definition)
  ())

(defmethod effective-slot-definition-class ((class project-managment-class)
					    &key (version-control-p t) &allow-other-keys)
  (case version-control-p
    (:collection (find-class 'collection-direct-slot-definition))
    (t (find-class 'property-direct-slot-definition))
    (otherwise (find-class 'standard-effective-slot-definition))))

(defmacro define-dependency (class-name &rest dependencies))
;; сделать слоты и зависимости независимыми друг от друга

;;(defclass property-slot-definition
;;    (standard-direct-slot-definition)
;;  ((table-name :initarg :table-name
;;	       :reader table-name-of)
;;   (project-id-column-name :initarg :project-id-column-name
;;			   :initform "project_id"
;;			   :reader project-id-column-name-of)
;;   (branch-id-column-name :initarg :branch-id-column-name
;;			  :initform "branch_id"
;;			  :reader branch-id-column-name-of)
;;   (commit-id-column-name :initarg :commit-id-column-name
;;			  :initform "commit_id"
;;			  :reader commit-id-column-name-of)))