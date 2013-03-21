(in-package #:projects-managment)

(defpclass* document ()
  ((document-type :type document-type)
   (registration-date :type date))
;;   (files :initform nil
;;	  :accessor files-of))
  (:documentation "Полученный и зарегистрированный документ"))

(defpassociation*
  ((:class document :slot project :type project)
   (:class project :slot documents :type document)))

(defpclass* document-file ()
  ((name :initarg :name
	 :accessor name-of)
   (mime-type :initarg :mime-type
	      :accessor mime-type)
   (content ;;:initform (создатьт поток)
	    :reader content-of)))

(defpclass* document-obtaining (task)
  ((document :accessor document-of
	     :documentation "Полученный и зарегистрированный документ"))
  (:documentation "Получение и регистрация документа. Фактическая дата выполнения - дата получения документа"))