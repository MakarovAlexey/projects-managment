(in-package #:projects-managment)

(defpclass* expense ()
  ((cost :type money))
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

(defpassociation*
  ((:class task :slot expenses
	   :type (hu.dwim.perec:set expense)
	   :documentation "Расходы связанные с задачей")
   (:class expense :slot task
	   :type task)))

(defpassociation*
  ((:class project :slot expenses
	   :type (hu.dwim.perec:set expense)
	   :documentation "Расходы связанные с проектом")
   (:class expense :slot project
	   :type project)))