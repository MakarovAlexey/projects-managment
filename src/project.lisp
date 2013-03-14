(in-package #:projects-managment)

(defclass project ()
  ((name :initarg :name
	 :accessor name-of)
   (branches :initform nil
	     :accessor branches-of)
   (current-branch :initform nil
		   :accessor current-branch)))

(defclass project-participant ()
  ((name :initarg :name
	 :accessor name-of)))

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
  (:documentation "Последствие наступления риска"))

(defclass risk-arrangement (task)
  ((risk :initarg :risk
	 :reader risk-of))
  (:documentation "Мероприятия по устранению риска"))

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