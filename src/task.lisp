(in-package #:projects-managment)

(defpclass* task ()
  ((name :type string))
  (:documentation "Мероприятие по проекту"))

(defpassociation*
  ((:class task :slot predecessors
	   :type (hu.dwim.perec:set task)
	   :documentation "Предшествующие задачи")
   (:class task :slot successors
	   :type (hu.dwim.perec:set task)
	   :documentation "Последующие задачи")))

(defpclass* person-allocation ()
  ((hours :type integer
	  :documentation "Количество часов выполнения работы"))
  (:documentation "Назначение трудового ресурса"))

(defpassociation*
  ((:class task :slot person-allocations
	   :type (hu.dwim.perec:set person-allocation)
	   :documentation "Назначения для ответственного")
   (:class person-allocation :slot task
	   :type task
	   :documentation "Задача для которой произведено назначение")))

(defpassociation*
  ((:class person-participation :slot allocations
	   :type (hu.dwim.perec:set person-allocation)
	   :documentation "Назначения для ответственного")
   (:class person-allocation :slot person-participation
	   :type person-participation
	   :documentation "Задача для которой произведено назначение")))

;; расходы
(defpclass expense ()
  ((cost :type money)
  (:documentation "Расход задачи"))

(defpassociation*
  ((:class expense :slot expense-item
	   :type expense-item
	   :documentation "Статья расхода")
   (:class expense-item :slot expenses
	   :type expense
	   :documentation "Расходы по статье. Включают все проекты")))

(defpassociation*
  ((:class task :slot expenses
	   :type (hu.dwim.perec:set expense)
	   :documentation "Расходы связанные с задачей")
   (:class expense :slot task
	   :type task)))

   (risk-effects :initform nil
		 :accessor risk-effects-of
		 :documentation "Возможные последствия реализации рисков")
   (actual-ending-date :type actual-ending-date-of
		       :documentation "Фактическая дата выполнения")

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

;; расчет даты начала --- максимальная дата окончания предшественников
;; дата окончания --- если указана фактическая дата, то возвращаем ее, иначе считаем макимальную длительность по ресурсам и прибавляем к дате начала