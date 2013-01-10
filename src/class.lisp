(in-package #:projects-managment)

(defclass project-managment-class (standard-class) ())

(defmethod validate-superclass ((class project-managment-class)
				(superclass standard-class))
  t)

(defclass repository ()
  ((branches :initform (make-array 0 :element-type branch
				   :fill-pointer t
				   :adjustable t)
	     :reader branches-of)))

(defclass branch ()
  ((commits :initform (make-array 0 :element-type commit
				  :fill-pointer t
				  :adjustable t)
	     :reader commits-of)))

(defclass commit ()
  ())

(defclass property-direct-slot-definition
    (standard-direct-slot-definition)
  ((version-control-p :initarg :version-control-p
		      :initform t
		      :reader version-control-p)))

(defmethod direct-slot-definition-class ((class project-managment-class)
					 &key (version-control-p t) &allow-other-keys)
  (if (not (null version-control-p))
      (find-class 'property-direct-slot-definition)
      (find-class 'standard-direct-slot-definition)))

(defclass property-effective-slot-definition
    (standard-effective-slot-definition)
  ())

(defclass collection-effective-slot-definition
    (standard-effective-slot-definition)
  ())

(defmethod effective-slot-definition-class ((class project-managment-class)
					    &key (version-control-p t) &allow-other-keys)
  (if (not (null version-control-p))
      (find-class 'property-direct-slot-definition)
      (find-class 'standard-effective-slot-definition)))

(defmacro define-dependency (class-name &rest dependencies))
;; сделать слоты и зависимости независимыми друг от друга