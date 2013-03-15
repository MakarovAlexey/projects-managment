(in-package #:projects-managment)

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