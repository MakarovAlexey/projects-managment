(in-package #:projects-managment)

(defpclass* task ()
  ((name :type string)
   (planned-days :type integer
		 :documentation "Запланированное количество дней для выполнения работы"))
  (:documentation "Мероприятие по проекту"))

(defpassociation*
  ((:class task :slot project :type project)
   (:class project :slot tasks
	   :type (hu.dwim.perec:set task))))

(defpassociation*
  ((:class task :slot project-participant
	   :type project-participant
	   :documentation "Назначения для ответственного")
   (:class project-participant-allocation
	   :slot tasks :type (hu.dwim.perec:set task)
	   :documentation "Задачи участника проекта")))

(defpclass* task-connection ()
  ())

(defpassociation*
  ((:class task-connection :slot successor :type task
	   :documentation "Последующая задача")
   (:class task :slot successors   
	   :type (hu.dwim.perec:set task-connection)
	   :documentation "Последующие связи")))

(defpclass* root-task-connection (task-connection)
  ()
  (:documentation ""))

(defpassociation*
  ((:class root-task-connection :slot project :type project)
   (:class project :slot root-task-connections
	   :type (hu.dwim.perec:set root-task-connection))))

(defpclass* common-task-connection (task-connection)
  ())

(defpassociation*
  ((:class common-task-connection :slot predecessor
	   :type task
	   :documentation "Предшествующая задача")
   (:class task :slot predecessors
	   :type (hu.dwim.perec:set common-task-connection)
	   :documentation "Предшествующие связи")))

;;   (actual-days :type integer
;;    :documentation "Фактическое количество дней выполнения работы") ;; может заменить списком обновления проекта?