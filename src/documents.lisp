(in-package :projects-managment)

(defclass file ()
  ((lo :initarg :oid
       :reader lo-of
       :documentation "Идентификатор файла и одновременно идентификатор LOB'a")
   (content-type :initarg :content-type
		 :accessor content-type-of
		 :documentation "MIME-тип файла")
   (name :initarg :name
	 :accessor name-of
	 :documentation "Имя файла, может быть не уникальным")))

(defclass document-type ()
  ((id :initarg :id
       :reader id-of)
   (name :initarg :name
	 :accessor name-of)))

(defclass document ()
  ((project :initarg :project
	    :reader project-of)
   (document-type :initarg :document-type
		  :accessor document-type-of
		  :documentation "Тип документа, пиьсмо, договор и т.д.")
   (copy-type :initarg :copy-type
	      :accessor copy-type-of
	      :documentation "оригинал, копия или электронная копия")
   (name :initarg :name
	 :accessor name-of
	 :documentation "Название/Содержание")
   (files :initarg :files
	  :accessor files-of
	  :documentation "Файлы документа")
   (attachments :initarg :attachments
		:accessor attachments-of
		:documentation "документы на которые ссылается данный документ")))

(defclass incoming-document (document)
  (;;(number :documentation "Номер по реестру") в преокте номером по реестру будет индекс в массиве хранящем документы
   (sender :initarg :sender
	   :accessor sender-of
	   :documentation "Контрагент-отправитель")))

(defclass outgoing-document (document)
  (;;(number :documentation "Номер по реестру")
   (reciever :initarg :sender
	     :accessor sender-of
	     :documentation "Контрагент-получатель")))

(defclass inner-document (document)
  (;;(number :documentation "Номер по реестру")
   (sender :initarg :sender
	   :accessor sender-of
	   :documentation "Сотрудник-отпарвитель")
   (reciever :initarg :sender
	     :accessor sender-of
	     :documentation "Сотрудник-получатель")))

;; task:id (parent-task-id index) предписание:id (project-id index)

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