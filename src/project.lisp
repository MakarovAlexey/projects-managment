(in-package #:projects-managment)

(defpclass* project ()
  ((name :type string)))

(defpclass* project-participant ()
  ((name :type string)))

(defpassociation*
  ((:class project :slot project-participants
	   :type (hu.dwim.perec:set project-participant))
   (:class project-participant
	   :slot project :type project)))

(defpclass* user ()
  ((name :type string)
   (login :type string)
   (password :type string)
   (email :type string))
  (:documentation "Пользователь системы, ответственный исполнитель"))

(defpclass* membership ()
  ()
  (:documentation "Участие в одной из групп реализации проекта"))

(defpassociation*
  ((:class membership :slot project-participant :type project-participant)
   (:class project-participant :slot memberships :type (hu.dwim.perec:set membership))))

(defpassociation*
  ((:class membership :slot user :type user)
   (:class user :slot memberships :type membership)))