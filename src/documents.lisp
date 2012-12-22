(in-package :projects-managment)

;;

;;(defclass process-instance ()
;;  ((process :initarg :process
;;	    :reader :process-of)
;;   (dependencies :initform (make-hash-table)
;;		 :reader dependencies-of)
;;   (comment :initarg :comment
;;	    :initform (error "Задаче необходимо дать описание")
;;	    :accessor comment-of)
;;   (employee :initarg :employee
;;	     :initform (error "Укажите исполнителя")
;;	     :accessor employee-of)
;;   (begin-date :initarg :begin-date
;;	       :initform (error "Необходимо указать дату начала задачи")
;;	       :accessor begin-date-of)
;;   (end-date :initarg :end-date
;;	     :initform (error "Необходимо указать дату завершения задачи")
;;	     :accessor end-date-of)))

;;(defclass project ()
;;  ((name :initarg :name
;;	 :initform (error "Необходимо указать название проекта")
;;	 :accessor name-of)
;;   (manager :initarg :manager
;;	    :initform (error "Укажите управляющего проектом")
;;	    :accessor manager-of)
;;   (process-instances :initform (make-array 0 :element-type 'process-instance)
;;		      :reader process-instances-of)))

;;(defclass person ()
;;  ((name :initarg :name :accessor name-of)
;;   (last-name :initarg :last-name :accessor name-of)
;;   (middle-name :initarg :middle-name :accessor middle-name-of)
;;   (tasks :initform (make-array 0 :element-type 'task))
;;   (managed-projects :initform (make-array 0 :element-type 'project))))
;; зависимость н агруппу - из группы выбираются тех. процессы, определнный процесс ставится в ависимость о тэтих процессов

;; зависимости, н группу и на процесс. Зависимость н апроцесс строгая - включение тех. прцесса в преокт обяательно. Зависимость на группу не строгая, можно включать лишь чатсь процессов которые укзаны в группе (процессы выбираемые из группы "тянут" за собой остальное)

;;альшевская оленин бурзянцев