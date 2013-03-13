;;;; projects-managment.lisp

(in-package #:projects-managment)

;;; "projects-managment" goes here. Hacks and glory await!

(defclass project ()
  ((name :initarg :name
	 :accessor name-of)
   (branches :initform nil
	     :accessor branches-of)
   (current-branch :initform nil
		   :accessor current-branch)))

(defclass branch ()
  ((project :initarg :project
	    :reader project-of)
   (name :initarg :name
	 :accessor name-of)
   (current-transaction :initform nil
			:accessor current-changes-of
			:documentation "Все транзакции ветки")
   (commited-transactions :initform nil
			  :accessor transactions-of
			  :documentation "Вариант проекта. В них сосредоточена работа над проектом")))

(defclass transaction ()
  ((branch :initarg :branch
	   :accessor branch-of)))

(defclass editing (transaction)
  ())

(defclass commited-transaction (transaction)
  ())

(defclass merging (commited-transaction)
  ((transaction :initarg :transaction
		:accessor transaction-of))
  (:documentation "Применение изменений из одной ветки в другую"))

(defclass task ()
  ((name :initarg :name
	 :accessor name-of)
   (predecessors :initform nil
		 :accessor predecessors-of
		 :documentation "Предшествующие задачи")
   (successors :initform nil
	       :accessor successors-of
	       :documentation "Последующие задачи")
   (risk-effects :initform nil
		 :accessor risk-effects-of
		 :documentation "Возможные последствия реализации рисков")
   (person-allocations :initform nil
		       :accessor person-allocations-of
		       :documentation "Ответственные исполнители")
   (expenses :initform nil
	     :accessor expenses-of
	     :documentation "Расходы связанные с задачей")
   (actual-ending-date :accessor actual-ending-date-of
		       :documentation "Фактическая дата выполнения"))
  (:documentation "Мероприятие по проекту"))

;; расчет даты начала --- максимальная дата окончания предшественников
;; дата окончания --- если указана фактическая дата, то возвращаем ее, иначе считаем макимальную длительность по ресурсам и прибавляем к дате начала
;; расходы
(defclass expense-item ()
  ((name :initarg :name
	 :accessor name-of))
  (:documentation "Статья расходов"))

(defclass expence ()
  ((expence-item :initarg :expence-item
		 :accessor expence-item-of))
  (:documentation "Расход задачи"))

;; каждый ресурс - незаменяемый, пользователь тоже будет ресурсом системы
(defclass person-allocation ()
  ((person :initarg :person
	   :accessor person-of
	   :documentation "Ответственное лицо (исполнитель)")
   (working-hours :initarg :working-hours
		  :accessor working-hours
		  :documentation "Количество часов выполнения работы"))
  (:documentation "Назначение трудового ресурса"))

(defclass risk (branch)
  ((name :initarg :name
	 :accessor name-of
	 :documentation "Название")
   (description :initarg :description
		:accessor description-of
		:documentation "Описание риска (причина, последствия, мероприятия по устранению)")
   (effects :initform nil
	    :accessor effects-of
	    :documentation "Последствия наступления")
   (arrangements :initform nil
		 :accessor arrangements-of
		 :documentation "Мероприятия по устранению риска"))
  (:documentation "Вариантное изменение. Нечто среднее между транзакцией изменений и веткой. Вступает в силу при определенных условиях. В сущности таже ветка проекта, но такая, которая сама является частью варианта проекта"))

;; контроль версий списка рисков проекта
;;

;; возможно следующие классы не нужны и отношение следует рассматривать с помощью обычной задачи

(defclass risk-effect (task)
  ((risk :initarg :risk
	 :reader risk-of))
  (:doocumentation "Последствие наступления риска"))

(defclass risk-arrangement (task)
  ((risk :initarg :risk
	 :reader risk-of))
  (:doocumentation "Мероприятия по устранению риска"))

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

(defclass document-obtaining (task)
  ((document :accessor document-of
	     :documentation "Полученный и зарегистрированный документ"))
  (:documentation "Получение и регистрация документа. Фактическая дата выполнения - дата получения документа"))

(defclass document ()
  ((document-type :initarg :document-type
		  :reader document-type-of)
   (registration-date :initarg :registration-date
		      :reader registration-date-of)
   (files :initform nil
	  :accessor files-of))
  (:documentation "Полученный и зарегистрированный документ"))

(defclass file ()
  ((name :initarg :name
	 :accessor name-of)
   (mime-type :initarg :mime-type
	      :accessor mime-type)
   (content :initform (создатьт поток)
	    :reader content-of)))

;; получение и регистрация документа
;; составление документа иногда бывает длительным процессом
;; например, составление процентовки

(defclass organization ()
  ((name :initarg :name
	 :accessor name-of)
   (employees :initform nil
	      :accessor employees-of)))

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

;; (managed-projects :initform nil
;;		     :accessor managed-projects-of
;;		     :documentation "Управляемые проекты. Участие в том или ином проекте определяется назначением на выолнение задач")

;; root работает с: пользователями, создает проекты, работает контрагентами (записи контрагентов), рабоатет с записаями сотрудников организаций